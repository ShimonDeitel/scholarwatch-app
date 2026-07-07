import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(Theme.accent)
                Text("Deadline Reminders")
                    .font(Theme.titleFont(26))
                    .foregroundStyle(Theme.ink)
                Text("Get renewal tracking and reminders before scholarship deadlines pass.")
                    .font(Theme.bodyFont(15))
                    .foregroundStyle(Theme.mutedInk)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Text("Unlocks: Deadline reminders and renewal tracking")
                    .font(Theme.labelFont(12))
                    .foregroundStyle(Theme.mutedInk)
                    .padding(.horizontal, 32)
                    .multilineTextAlignment(.center)

                if let product = purchases.product {
                    Button {
                        Task { await purchases.purchase() }
                    } label: {
                        Text("Continue — \(product.displayPrice)")
                            .font(Theme.labelFont(16))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent)
                            .clipShape(RoundedRectangle(cornerRadius: Theme.cornerRadius))
                    }
                    .padding(.horizontal, 32)
                    .accessibilityIdentifier("purchaseButton")
                } else {
                    ProgressView()
                }

                Button("Restore Purchases") {
                    Task { await purchases.restore() }
                }
                .font(Theme.labelFont(13))
                .foregroundStyle(Theme.mutedInk)
                .accessibilityIdentifier("paywallRestoreButton")

                Button("Not Now") {
                    dismiss()
                }
                .font(Theme.labelFont(13))
                .foregroundStyle(Theme.mutedInk)
                .accessibilityIdentifier("dismissPaywallButton")
                Spacer()
            }
        }
        .onChange(of: purchases.isPurchased) { _, newValue in
            if newValue { dismiss() }
        }
    }
}
