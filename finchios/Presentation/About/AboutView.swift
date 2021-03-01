//
//  AboutVIew.swift
//  finchios
//
//  Created by Brett Fazio on 2/19/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            Text("""
                Finch is the personal finance app that lets you visualise and learn about your finances, improve your financial habits, and plan for your financial future. It starts simply: see all your finances and accounts in one place. You can input recurring income and expenses (including custom ones) to see how they contribute to your net worth over time. You can even set growth goals for yourself and track your progress.

                Then, you can choose from a set of projections, or make your own, to see what your financial future could look like. With Finch, you can simulate how a stock market crash ten years from now will affect your retirement savings forty years from now, based on historical data – and much more. You can also define your own simulations based on events you expect to happen, like having children or going to graduate school, or taking a sabbatical to backpack around Europe.

                Finch also includes something incredibly novel: the ability to see in real-time how your financial standing stacks up against others like you; ever wonder how much you save compared to other Software Engineers in your city? What about, right now, if you’re spending comparatively little on rent? Finch lets you answer these questions and learn about your relative financial health and encourage you to make good financial choices – and all while guarding the privacy of every customer.

                We know that good financial health is not only about how much you spend or save. It’s also about where you put your money. Finch uses powerful data-driven clustering to recommend financial products to the user. If all your friends have a high interest savings account, shouldn’t you? We hope that Finch gets people excited about their future – and motivates them to make it even brighter.

                iOS App developed by Brett Fazio.

                Rest of finch team are Heath Milligan, Charles Bailey, William Chen, and Andy Phan.
                """)
                .padding()
        }
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
