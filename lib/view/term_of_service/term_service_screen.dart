import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

class TermOfServiceScreen extends StatelessWidget {
  const TermOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 30.h,
            color: whiteColor,
          ),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: 'Term of service'
            .appCommonText(color: whiteColor, weight: FontWeight.w700),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "AGREEMENT TO OUR LEGAL TERMS".appCommonText(
                color: Theme.of(context).secondaryHeaderColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            'We are Hotlines, LLC, doing business as HotlinesCB and Hotlines ("Company," "we," "us," "our"), a company registered in Maryland, United States at 3570 Poole Street, Baltimore, MD 21211.\n\nWe operate the mobile application Hotlines, LLC (the "App"), as well as any other related products and services that refer or link to these legal terms (the "Legal Terms") (collectively, the "Services").\n\nYou can contact us by phone at 4438396507, email at casey@hotlinesmd.com, or by mail to 3570 Poole Street, Baltimore, MD 21211, United States.\n\nThese Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ("you"), and Hotlines, LLC, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.\n\nWe will provide you with prior notice of any scheduled changes to the Services you are using. Changes to Legal Terms will become effective one (1) days after the notice is given, except if the changes apply to new functionality, security updates, bug fixes, and a court order, in which case the changes will be effective immediately. By continuing to use the Services after the effective date of any changes, you agree to be bound by the modified terms. If you disagree with such changes, you may terminate Services as per the section "TERM AND TERMINATION."\n\nThe Services are intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to use or register for the Services.\n\nWe recommend that you print a copy of these Legal Terms for your records.'
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "1. OUR SERVICES"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            'The information provided when using the Services is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Services from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.\n\nThe Services are not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use the Services. You may not use the Services in a way that would violate the Gramm-Leach-Bliley Act (GLBA).'
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "2. INTELLECTUAL PROPERTY RIGHTS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "Our intellectual property"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "We are the owner or the licensee of all intellectual property rights in our Services, including all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics in the Services (collectively, the 'Content'), as well as the trademarks, service marks, and logos contained therein (the 'Marks').\n\nOur Content and Marks are protected by copyright and trademark laws (and various other intellectual property rights and unfair competition laws) and treaties in the United States and around the world.\n\nThe Content and Marks are provided in or through the Services 'AS IS' for your personal, non-commercial use or internal business purpose only."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "Your use of our Services"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "Subject to your compliance with these Legal Terms, including the 'PROHIBITED ACTIVITIES' section below, we grant you a non-exclusive, non-transferable, revocable license to:\n\naccess the Services; and\n\ndownload or print a copy of any portion of the Content to which you have properly gained access.\n\nsolely for your personal, non-commercial use or internal business purpose.\n\nExcept as set out in this section or elsewhere in our Legal Terms, no part of the Services and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.\n\nIf you wish to make any use of the Services, Content, or Marks other than as set out in this section or elsewhere in our Legal Terms, please address your request to: casey@hotlinesmd.com. If we ever grant you the permission to post, reproduce, or publicly display any part of our Services or Content, you must identify us as the owners or licensors of the Services, Content, or Marks and ensure that any copyright or proprietary notice appears or is visible on posting, reproducing, or displaying our Content.\n\nWe reserve all rights not expressly granted to you in and to the Services, Content, and Marks.\n\nAny breach of these Intellectual Property Rights will constitute a material breach of our Legal Terms and your right to use our Services will terminate immediately."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "3. USER REPRESENTATIONS"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "By using the Services, you represent and warrant that: (1) you have the legal capacity and you agree to comply with these Legal Terms; (2) you are not a minor in the jurisdiction in which you reside; (3) you will not access the Services through automated or non-human means, whether through a bot, script or otherwise; (4) you will not use the Services for any illegal or unauthorized purpose; and (5) your use of the Services will not violate any applicable law or regulation.\n\nIf you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Services (or any portion thereof)."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "4. PROHIBITED ACTIVITIES"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "You may not access or use the Services for any purpose other than that for which we make the Services available. The Services may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.\n\nAs a user of the Services, you agree not to:\n\nSystematically retrieve data or other content from the Services to create or compile, directly or indirectly, a collection, compilation, database, or directory without written permission from us.\n\nTrick, defraud, or mislead us and other users, especially in any attempt to learn sensitive account information such as user passwords.\n\nCircumvent, disable, or otherwise interfere with security-related features of the Services, including features that prevent or restrict the use or copying of any Content or enforce limitations on the use of the Services and/or the Content contained therein.\n\nDisparage, tarnish, or otherwise harm, in our opinion, us and/or the Services.\n\nUse any information obtained from the Services in order to harass, abuse, or harm another person.\n\nMake improper use of our support services or submit false reports of abuse or misconduct.\n\nUse the Services in a manner inconsistent with any applicable laws or regulations.\n\nEngage in unauthorized framing of or linking to the Services.\n\nUpload or transmit (or attempt to upload or to transmit) viruses, Trojan horses, or other material, including excessive use of capital letters and spamming (continuous posting of repetitive text), that interferes with any party’s uninterrupted use and enjoyment of the Services or modifies, impairs, disrupts, alters, or interferes with the use, features, functions, operation, or maintenance of the Services.\n\nEngage in any automated use of the system, such as using scripts to send comments or messages, or using any data mining, robots, or similar data gathering and extraction tools.\n\nDelete the copyright or other proprietary rights notice from any Content.\n\nAttempt to impersonate another user or person or use the username of another user.\n\nUpload or transmit (or attempt to upload or to transmit) any material that acts as a passive or active information collection or transmission mechanism, including without limitation, clear graphics interchange formats ('gifs'), 1×1 pixels, web bugs, cookies, or other similar devices (sometimes referred to as 'spyware' or 'passive collection mechanisms' or 'pcms).\n\nInterfere with, disrupt, or create an undue burden on the Services or the networks or services connected to the Services.\n\nHarass, annoy, intimidate, or threaten any of our employees or agents engaged in providing any portion of the Services to you.\n\nAttempt to bypass any measures of the Services designed to prevent or restrict access to the Services, or any portion of the Services.\n\nCopy or adapt the Services' software, including but not limited to Flash, PHP, HTML, JavaScript, or other code.\n\nExcept as permitted by applicable law, decipher, decompile, disassemble, or reverse engineer any of the software comprising or in any way making up a part of the Services.\n\nExcept as may be the result of standard search engine or Internet browser usage, use, launch, develop, or distribute any automated system, including without limitation, any spider, robot, cheat utility, scraper, or offline reader that accesses the Services, or use or launch any unauthorized script or other software.\n\nUse a buying agent or purchasing agent to make purchases on the Services.\n\nMake any unauthorized use of the Services, including collecting usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email, or creating user accounts by automated means or under false pretenses.\n\nUse the Services as part of any effort to compete with us or otherwise use the Services and/or the Content for any revenue-generating endeavor or commercial enterprise"
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "5. USER GENERATED CONTRIBUTIONS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "The Services does not offer users to submit or post content."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "6. CONTRIBUTION LICENSE"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "You and Services agree that we may access, store, process, and use any information and personal data that you provide and your choices (including settings).By submitting suggestions or other feedback regarding the Services, you agree that we can use and share such feedback for any purpose without compensation to you."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "7. MOBILE APPLICATION LICENSE".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "Use License"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "If you access the Services via the App, then we grant you a revocable, non-exclusive, non-transferable, limited right to install and use the App on wireless electronic devices owned or controlled by you, and to access and use the App on such devices strictly in accordance with the terms and conditions of this mobile application license contained in these Legal Terms. You shall not: (1) except as permitted by applicable law, decompile, reverse engineer, disassemble, attempt to derive the source code of, or decrypt the App; (2) make any modification, adaptation, improvement, enhancement, translation, or derivative work from the App; (3) violate any applicable laws, rules, or regulations in connection with your access or use of the App; (4) remove, alter, or obscure any proprietary notice (including any notice of copyright or trademark) posted by us or the licensors of the App; (5) use the App for any revenue-generating endeavor, commercial enterprise, or other purpose for which it is not designed or intended; (6) make the App available over a network or other environment permitting access or use by multiple devices or users at the same time; (7) use the App for creating a product, service, or software that is, directly or indirectly, competitive with or in any way a substitute for the App; (8) use the App to send automated queries to any website or to send any unsolicited commercial email; or (9) use any proprietary information or any of our interfaces or our other intellectual property in the design, development, manufacture, licensing, or distribution of any applications, accessories, or devices for use with the App."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "Apple and Android Devices".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "The following terms apply when you use the App obtained from either the Apple Store or Google Play (each an 'App Distributor') to access the Services: (1) the license granted to you for our App is limited to a non-transferable license to use the application on a device that utilizes the Apple iOS or Android operating systems, as applicable, and in accordance with the usage rules set forth in the applicable App Distributor’s terms of service; (2) we are responsible for providing any maintenance and support services with respect to the App as specified in the terms and conditions of this mobile application license contained in these Legal Terms or as otherwise required under applicable law, and you acknowledge that each App Distributor has no obligation whatsoever to furnish any maintenance and support services with respect to the App; (3) in the event of any failure of the App to conform to any applicable warranty, you may notify the applicable App Distributor, and the App Distributor, in accordance with its terms and policies, may refund the purchase price, if any, paid for the App, and to the maximum extent permitted by applicable law, the App Distributor will have no other warranty obligation whatsoever with respect to the App; (4) you represent and warrant that (i) you are not located in a country that is subject to a US government embargo, or that has been designated by the US government as a 'terrorist supporting' country and (ii) you are not listed on any US government list of prohibited or restricted parties; (5) you must comply with applicable third-party terms of agreement when using the App, e.g., if you have a VoIP application, then you must not be in violation of their wireless data service agreement when using the App; and (6) you acknowledge and agree that the App Distributors are third-party beneficiaries of the terms and conditions in this mobile application license contained in these Legal Terms, and that each App Distributor will have the right (and will be deemed to have accepted the right) to enforce the terms and conditions in this mobile application license contained in these Legal Terms against you as a third-party beneficiary thereof."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "8. THIRD-PARTY WEBSITES AND CONTENT".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "The Services may contain (or you may be sent via the App) links to other websites ('Third-Party Websites') as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties ('Third-Party Content'). Such Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the Services or any Third-Party Content posted on, available through, or installed from the Services, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content. Inclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Services and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Legal Terms no longer govern. You should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the Services or relating to any applications you use or install from the Services. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party. You agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us blameless from any harm caused by your purchase of such products or services. Additionally, you shall hold us blameless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "9. ADVERTISERS"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "We allow advertisers to display their advertisements and other information in certain areas of the Services, such as sidebar advertisements or banner advertisements. We simply provide the space to place such advertisements, and we have no other relationship with advertisers."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "10. SERVICES MANAGEMENT"
                .appCommonText(color: blackColor, weight: FontWeight.bold),
            20.h.H(),
            "We reserve the right, but not the obligation, to: (1) monitor the Services for violations of these Legal Terms; (2) take appropriate legal action against anyone who, in our sole discretion, violates the law or these Legal Terms, including without limitation, reporting such user to law enforcement authorities; (3) in our sole discretion and without limitation, refuse, restrict access to, limit the availability of, or disable (to the extent technologically feasible) any of your Contributions or any portion thereof; (4) in our sole discretion and without limitation, notice, or liability, to remove from the Services or otherwise disable all files and content that are excessive in size or are in any way burdensome to our systems; and (5) otherwise manage the Services in a manner designed to protect our rights and property and to facilitate the proper functioning of the Services"
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "11. TERM AND TERMINATION".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "These Legal Terms shall remain in full force and effect while you use the Services. WITHOUT LIMITING ANY OTHER PROVISION OF THESE LEGAL TERMS, WE RESERVE THE RIGHT TO, IN OUR SOLE DISCRETION AND WITHOUT NOTICE OR LIABILITY, DENY ACCESS TO AND USE OF THE SERVICES (INCLUDING BLOCKING CERTAIN IP ADDRESSES), TO ANY PERSON FOR ANY REASON OR FOR NO REASON, INCLUDING WITHOUT LIMITATION FOR BREACH OF ANY REPRESENTATION, WARRANTY, OR COVENANT CONTAINED IN THESE LEGAL TERMS OR OF ANY APPLICABLE LAW OR REGULATION. WE MAY TERMINATE YOUR USE OR PARTICIPATION IN THE SERVICES OR DELETE ANY CONTENT OR INFORMATION THAT YOU POSTED AT ANY TIME, WITHOUT WARNING, IN OUR SOLE DISCRETION.\n\nIf we terminate or suspend your account for any reason, you are prohibited from registering and creating a new account under your name, a fake or borrowed name, or the name of any third party, even if you may be acting on behalf of the third party. In addition to terminating or suspending your account, we reserve the right to take appropriate legal action, including without limitation pursuing civil, criminal, and injunctive redress."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "12. MODIFICATIONS AND INTERRUPTIONS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "We reserve the right to change, modify, or remove the contents of the Services at any time or for any reason at our sole discretion without notice. However, we have no obligation to update any information on our Services. We will not be liable to you or any third party for any modification, price change, suspension, or discontinuance of the Services.\n\nWe cannot guarantee the Services will be available at all times. We may experience hardware, software, or other problems or need to perform maintenance related to the Services, resulting in interruptions, delays, or errors. We reserve the right to change, revise, update, suspend, discontinue, or otherwise modify the Services at any time or for any reason without notice to you. You agree that we have no liability whatsoever for any loss, damage, or inconvenience caused by your inability to access or use the Services during any downtime or discontinuance of the Services. Nothing in these Legal Terms will be construed to obligate us to maintain and support the Services or to supply any corrections, updates, or releases in connection therewith."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "13. GOVERNING LAW".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "These Legal Terms and your use of the Services are governed by and construed in accordance with the laws of the State of Maryland applicable to agreements made and to be entirely performed within the State of Maryland, without regard to its conflict of law principles."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "14. DISPUTE RESOLUTION".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "Any legal action of whatever nature brought by either you or us (collectively, the 'Parties' and individually, a 'Party') shall be commenced or prosecuted in the state and federal courts located in Baltimore City, Maryland, and the Parties hereby consent to, and waive all defenses of lack of personal jurisdiction and forum non conveniens with respect to venue and jurisdiction in such state and federal courts. Application of the United Nations Convention on Contracts for the International Sale of Goods and the Uniform Computer Information Transaction Act (UCITA) are excluded from these Legal Terms. In no event shall any claim, action, or proceeding brought by either Party related in any way to the Services be commenced more than one (1) years after the cause of action arose."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "15. CORRECTIONS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "There may be information on the Services that contains typographical errors, inaccuracies, or omissions, including descriptions, pricing, availability, and various other information. We reserve the right to correct any errors, inaccuracies, or omissions and to change or update the information on the Services at any time, without prior notice."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "16. DISCLAIMER".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "THE SERVICES ARE PROVIDED ON AN AS-IS AND AS-AVAILABLE BASIS. YOU AGREE THAT YOUR USE OF THE SERVICES WILL BE AT YOUR SOLE RISK. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, IN CONNECTION WITH THE SERVICES AND YOUR USE THEREOF, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY OR COMPLETENESS OF THE SERVICES' CONTENT OR THE CONTENT OF ANY WEBSITES OR MOBILE APPLICATIONS LINKED TO THE SERVICES AND WE WILL ASSUME NO LIABILITY OR RESPONSIBILITY FOR ANY (1) ERRORS, MISTAKES, OR INACCURACIES OF CONTENT AND MATERIALS, (2) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF THE SERVICES, (3) ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN, (4) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE SERVICES, (5) ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE SERVICES BY ANY THIRD PARTY, AND/OR (6) ANY ERRORS OR OMISSIONS IN ANY CONTENT AND MATERIALS OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE SERVICES. WE DO NOT WARRANT, ENDORSE, GUARANTEE, OR ASSUME RESPONSIBILITY FOR ANY PRODUCT OR SERVICE ADVERTISED OR OFFERED BY A THIRD PARTY THROUGH THE SERVICES, ANY HYPERLINKED WEBSITE, OR ANY WEBSITE OR MOBILE APPLICATION FEATURED IN ANY BANNER OR OTHER ADVERTISING, AND WE WILL NOT BE A PARTY TO OR IN ANY WAY BE RESPONSIBLE FOR MONITORING ANY TRANSACTION BETWEEN YOU AND ANY THIRD-PARTY PROVIDERS OF PRODUCTS OR SERVICES. AS WITH THE PURCHASE OF A PRODUCT OR SERVICE THROUGH ANY MEDIUM OR IN ANY ENVIRONMENT, YOU SHOULD USE YOUR BEST JUDGMENT AND EXERCISE CAUTION WHERE APPROPRIATE."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "17. LIMITATIONS OF LIABILITY".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "IN NO EVENT WILL WE OR OUR DIRECTORS, EMPLOYEES, OR AGENTS BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL, OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT, LOST REVENUE, LOSS OF DATA, OR OTHER DAMAGES ARISING FROM YOUR USE OF THE SERVICES, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OUR LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE LESSER OF THE AMOUNT PAID, IF ANY, BY YOU TO US DURING THE SIX (6) MONTH PERIOD PRIOR TO ANY CAUSE OF ACTION ARISING OR . CERTAIN US STATE LAWS AND INTERNATIONAL LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MAY HAVE ADDITIONAL RIGHTS."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "18. INDEMNIFICATION".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "You agree to defend, indemnify, and hold us harmless, including our subsidiaries, affiliates, and all of our respective officers, agents, partners, and employees, from and against any loss, damage, liability, claim, or demand, including reasonable attorneys’ fees and expenses, made by any third party due to or arising out of: (1) use of the Services; (2) breach of these Legal Terms; (3) any breach of your representations and warranties set forth in these Legal Terms; (4) your violation of the rights of a third party, including but not limited to intellectual property rights; or (5) any overt harmful act toward any other user of the Services with whom you connected via the Services. Notwithstanding the foregoing, we reserve the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate, at your expense, with our defense of such claims. We will use reasonable efforts to notify you of any such claim, action, or proceeding which is subject to this indemnification upon becoming aware of it."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "19. USER DATA".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "We will maintain certain data that you transmit to the Services for the purpose of managing the performance of the Services, as well as data relating to your use of the Services. Although we perform regular routine backups of data, you are solely responsible for all data that you transmit or that relates to any activity you have undertaken using the Services. You agree that we shall have no liability to you for any loss or corruption of any such data, and you hereby waive any right of action against us arising from any such loss or corruption of such data."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "20. ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES"
                .appCommonText(
                    color: blackColor,
                    weight: FontWeight.bold,
                    align: TextAlign.start),
            20.h.H(),
            "Visiting the Services, sending us emails, and completing online forms constitute electronic communications. You consent to receive electronic communications, and you agree that all agreements, notices, disclosures, and other communications we provide to you electronically, via email and on the Services, satisfy any legal requirement that such communication be in writing. YOU HEREBY AGREE TO THE USE OF ELECTRONIC SIGNATURES, CONTRACTS, ORDERS, AND OTHER RECORDS, AND TO ELECTRONIC DELIVERY OF NOTICES, POLICIES, AND RECORDS OF TRANSACTIONS INITIATED OR COMPLETED BY US OR VIA THE SERVICES. You hereby waive any rights or requirements under any statutes, regulations, rules, ordinances, or other laws in any jurisdiction which require an original signature or delivery or retention of non-electronic records, or to payments or the granting of credits by any means other than electronic means."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "21. CALIFORNIA USERS AND RESIDENTS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "If any complaint with us is not satisfactorily resolved, you can contact the Complaint Assistance Unit of the Division of Consumer Services of the California Department of Consumer Affairs in writing at 1625 North Market Blvd., Suite N 112, Sacramento, California 95834 or by telephone at (800) 952-5210 or (916) 445-1254."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "22. MISCELLANEOUS".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "These Legal Terms and any policies or operating rules posted by us on the Services or in respect to the Services constitute the entire agreement and understanding between you and us. Our failure to exercise or enforce any right or provision of these Legal Terms shall not operate as a waiver of such right or provision. These Legal Terms operate to the fullest extent permissible by law. We may assign any or all of our rights and obligations to others at any time. We shall not be responsible or liable for any loss, damage, delay, or failure to act caused by any cause beyond our reasonable control. If any provision or part of a provision of these Legal Terms is determined to be unlawful, void, or unenforceable, that provision or part of the provision is deemed severable from these Legal Terms and does not affect the validity and enforceability of any remaining provisions. There is no joint venture, partnership, employment or agency relationship created between you and us as a result of these Legal Terms or use of the Services. You agree that these Legal Terms will not be construed against us by virtue of having drafted them. You hereby waive any and all defenses you may have based on the electronic form of these Legal Terms and the lack of signing by the parties hereto to execute these Legal Terms."
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "23. CONTACT US".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "In order to resolve a complaint regarding the Services or to receive further information regarding use of the Services, please contact us at: "
                .appCommonText(
                    color: greyColor, size: 18.h, align: TextAlign.start),
            20.h.H(),
            "Hotlines, LLC\n3570 Poole Street\nBaltimore, MD 21211\nUnited States\nPhone: 4438396507\ncasey@hotlinesmd.com"
                .appCommonText(
                    color: Colors.black,
                    size: 18.h,
                    weight: FontWeight.bold,
                    align: TextAlign.start),
            20.h.H(),
          ],
        ).paddingSymmetric(horizontal: 20.h, vertical: 30.h),
      ),
    );
  }
}
