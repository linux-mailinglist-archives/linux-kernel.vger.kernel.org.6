Return-Path: <linux-kernel+bounces-267870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44499417D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897F42865B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508818B49C;
	Tue, 30 Jul 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkGBC0fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CB18B492;
	Tue, 30 Jul 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355966; cv=none; b=iFXZplx5m4fLbfJxYXHkZ/vrCQmMRJrDZQThhK91AayR7gjnlublqFDA34L7ug8C5QM52DRXpu7oSKv91DlqQ582nPvu7wpNgPaINuNoPQi+D57fAd/nYYoJxJ2jvzRBC/lXpAl3NVM1JuSKqOzf1bl/HMnyfskadQ3/Abgu02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355966; c=relaxed/simple;
	bh=kKonLJXt4dPyYwKaL3qLTW+GASb6K3eeslLpbTlLUz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUjtUJn/24rl/Gf2HBPjF/thMGq3TdpWBIMm3PJr0HyEN/cUSFboWXHRq8hSU/lpKp2nmpqQZ8bSsLWg4LmaSnPF1vfnD6ogFMZBGZQ9Ept0BuyjrszaWwNmJuAzC90iOfAaQtOmPUSRXlCwLok8GOeS1GEgaRSVbR0hit/9B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qkGBC0fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38D4C4AF0A;
	Tue, 30 Jul 2024 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355966;
	bh=kKonLJXt4dPyYwKaL3qLTW+GASb6K3eeslLpbTlLUz0=;
	h=From:To:Cc:Subject:Date:From;
	b=qkGBC0fuRo24WxMX7Fq2oqU7N6lJAW4o4w6SibrDmElng/xw2yJLiC2Xh5DbyHdKM
	 qqYyAqGI9O3b/04uDegFduwJHro28b6hIzB2c/lJwrHDrxfofe4rsrpAsLQJHiDlTU
	 UVa9xZgAo4yYcubRoF6CkU/ak0N+saRWjH19VlGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Dolan <mdolan@linuxfoundation.org>
Subject: [PATCH 1/2] Documentation: embargoed-hardware-issues.rst: minor cleanups and fixes
Date: Tue, 30 Jul 2024 18:09:31 +0200
Message-ID: <2024073032-outsource-sniff-e8ea@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 275
X-Developer-Signature: v=1; a=openpgp-sha256; l=14818; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=kKonLJXt4dPyYwKaL3qLTW+GASb6K3eeslLpbTlLUz0=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkrBWyuyW2a+TchaKvmb7kf78SW+IgJze5RYPewvit/T /f8yzXCHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRmdkM86xOLtz48D+Xys+p wg6yE2sFXn+vNmCYp6XRdaMpLvuiaujhXy/mbeJScCxNAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The embargoed-hardware-issues.rst file needed a bunch of minor grammar,
punctuation, and syntax cleanups based on feedback we have gotten over
the past few years.  The main change here is the term "silicon" being
used over "hardware" to differentiate between companies that make a chip
(i.e. a CPU) and those that take the chip and put it into their system.

No process changes are made here at all, only clarification for the way
the current process works.

All of these changes have been approved by a review from a large number
of different open source legal members, representing the companies
involved in this process.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Michael Dolan <mdolan@linuxfoundation.org>
Signed-off-by: Michael Dolan <mdolan@linuxfoundation.org>
Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Jon, I can take these changes through my tree if you don't object.

 .../process/embargoed-hardware-issues.rst     | 122 ++++++++++--------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 6e9a4597bf2c..2b34bb6b7cda 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -13,9 +13,9 @@ kernel.
 Hardware issues like Meltdown, Spectre, L1TF etc. must be treated
 differently because they usually affect all Operating Systems ("OS") and
 therefore need coordination across different OS vendors, distributions,
-hardware vendors and other parties. For some of the issues, software
-mitigations can depend on microcode or firmware updates, which need further
-coordination.
+silicon vendors, hardware integrators, and other parties. For some of the
+issues, software mitigations can depend on microcode or firmware updates,
+which need further coordination.
 
 .. _Contact:
 
@@ -32,8 +32,8 @@ Linux kernel security team (:ref:`Documentation/admin-guide/
 <securitybugs>`) instead.
 
 The team can be contacted by email at <hardware-security@kernel.org>. This
-is a private list of security officers who will help you to coordinate a
-fix according to our documented process.
+is a private list of security officers who will help you coordinate a fix
+according to our documented process.
 
 The list is encrypted and email to the list can be sent by either PGP or
 S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
@@ -43,7 +43,7 @@ the following URLs:
   - PGP: https://www.kernel.org/static/files/hardware-security.asc
   - S/MIME: https://www.kernel.org/static/files/hardware-security.crt
 
-While hardware security issues are often handled by the affected hardware
+While hardware security issues are often handled by the affected silicon
 vendor, we welcome contact from researchers or individuals who have
 identified a potential hardware flaw.
 
@@ -65,7 +65,7 @@ of Linux Foundation's IT operations personnel technically have the
 ability to access the embargoed information, but are obliged to
 confidentiality by their employment contract. Linux Foundation IT
 personnel are also responsible for operating and managing the rest of
-kernel.org infrastructure.
+kernel.org's infrastructure.
 
 The Linux Foundation's current director of IT Project infrastructure is
 Konstantin Ryabitsev.
@@ -85,7 +85,7 @@ Memorandum of Understanding
 
 The Linux kernel community has a deep understanding of the requirement to
 keep hardware security issues under embargo for coordination between
-different OS vendors, distributors, hardware vendors and other parties.
+different OS vendors, distributors, silicon vendors, and other parties.
 
 The Linux kernel community has successfully handled hardware security
 issues in the past and has the necessary mechanisms in place to allow
@@ -103,11 +103,11 @@ the issue in the best technical way.
 All involved developers pledge to adhere to the embargo rules and to keep
 the received information confidential. Violation of the pledge will lead to
 immediate exclusion from the current issue and removal from all related
-mailing-lists. In addition, the hardware security team will also exclude
+mailing lists. In addition, the hardware security team will also exclude
 the offender from future issues. The impact of this consequence is a highly
 effective deterrent in our community. In case a violation happens the
 hardware security team will inform the involved parties immediately. If you
-or anyone becomes aware of a potential violation, please report it
+or anyone else becomes aware of a potential violation, please report it
 immediately to the Hardware security officers.
 
 
@@ -124,14 +124,16 @@ method for these types of issues.
 Start of Disclosure
 """""""""""""""""""
 
-Disclosure starts by contacting the Linux kernel hardware security team by
-email. This initial contact should contain a description of the problem and
-a list of any known affected hardware. If your organization builds or
-distributes the affected hardware, we encourage you to also consider what
-other hardware could be affected.
+Disclosure starts by emailing the Linux kernel hardware security team per
+the Contact section above.  This initial contact should contain a
+description of the problem and a list of any known affected silicon. If
+your organization builds or distributes the affected hardware, we encourage
+you to also consider what other hardware could be affected.  The disclosing
+party is responsible for contacting the affected silicon vendors in a
+timely manner.
 
 The hardware security team will provide an incident-specific encrypted
-mailing-list which will be used for initial discussion with the reporter,
+mailing list which will be used for initial discussion with the reporter,
 further disclosure, and coordination of fixes.
 
 The hardware security team will provide the disclosing party a list of
@@ -158,8 +160,8 @@ This serves several purposes:
  - The disclosed entities can be contacted to name experts who should
    participate in the mitigation development.
 
- - If an expert which is required to handle an issue is employed by an
-   listed entity or member of an listed entity, then the response teams can
+ - If an expert who is required to handle an issue is employed by a listed
+   entity or member of an listed entity, then the response teams can
    request the disclosure of that expert from that entity. This ensures
    that the expert is also part of the entity's response team.
 
@@ -169,8 +171,8 @@ Disclosure
 The disclosing party provides detailed information to the initial response
 team via the specific encrypted mailing-list.
 
-From our experience the technical documentation of these issues is usually
-a sufficient starting point and further technical clarification is best
+From our experience, the technical documentation of these issues is usually
+a sufficient starting point, and further technical clarification is best
 done via email.
 
 Mitigation development
@@ -179,35 +181,39 @@ Mitigation development
 The initial response team sets up an encrypted mailing-list or repurposes
 an existing one if appropriate.
 
-Using a mailing-list is close to the normal Linux development process and
-has been successfully used in developing mitigations for various hardware
+Using a mailing list is close to the normal Linux development process and
+has been successfully used to develop mitigations for various hardware
 security issues in the past.
 
-The mailing-list operates in the same way as normal Linux development.
-Patches are posted, discussed and reviewed and if agreed on applied to a
-non-public git repository which is only accessible to the participating
+The mailing list operates in the same way as normal Linux development.
+Patches are posted, discussed, and reviewed and if agreed upon, applied to
+a non-public git repository which is only accessible to the participating
 developers via a secure connection. The repository contains the main
 development branch against the mainline kernel and backport branches for
 stable kernel versions as necessary.
 
 The initial response team will identify further experts from the Linux
-kernel developer community as needed. Bringing in experts can happen at any
-time of the development process and needs to be handled in a timely manner.
+kernel developer community as needed.  Any involved party can suggest
+further experts to be included, each of which will be subject to the same
+requirements outlined above.
 
-If an expert is employed by or member of an entity on the disclosure list
+Bringing in experts can happen at any time in the development process and
+needs to be handled in a timely manner.
+
+If an expert is employed by or a member of an entity on the disclosure list
 provided by the disclosing party, then participation will be requested from
 the relevant entity.
 
-If not, then the disclosing party will be informed about the experts
+If not, then the disclosing party will be informed about the experts'
 participation. The experts are covered by the Memorandum of Understanding
-and the disclosing party is requested to acknowledge the participation. In
-case that the disclosing party has a compelling reason to object, then this
-objection has to be raised within five work days and resolved with the
-incident team immediately. If the disclosing party does not react within
-five work days this is taken as silent acknowledgement.
+and the disclosing party is requested to acknowledge their participation.
+In the case where the disclosing party has a compelling reason to object,
+any objection must to be raised within five working days and resolved with
+the incident team immediately. If the disclosing party does not react
+within five working days this is taken as silent acknowledgment.
 
-After acknowledgement or resolution of an objection the expert is disclosed
-by the incident team and brought into the development process.
+After the incident team acknowledges or resolves an objection, the expert
+is disclosed and brought into the development process.
 
 List participants may not communicate about the issue outside of the
 private mailing list. List participants may not use any shared resources
@@ -217,19 +223,20 @@ private mailing list. List participants may not use any shared resources
 Coordinated release
 """""""""""""""""""
 
-The involved parties will negotiate the date and time where the embargo
-ends. At that point the prepared mitigations are integrated into the
-relevant kernel trees and published. There is no pre-notification process:
-fixes are published in public and available to everyone at the same time.
+The involved parties will negotiate the date and time when the embargo
+ends. At that point, the prepared mitigations are published into the
+relevant kernel trees.  There is no pre-notification process: the
+mitigations are published in public and available to everyone at the same
+time.
 
 While we understand that hardware security issues need coordinated embargo
-time, the embargo time should be constrained to the minimum time which is
-required for all involved parties to develop, test and prepare the
+time, the embargo time should be constrained to the minimum time that is
+required for all involved parties to develop, test, and prepare their
 mitigations. Extending embargo time artificially to meet conference talk
-dates or other non-technical reasons is creating more work and burden for
-the involved developers and response teams as the patches need to be kept
-up to date in order to follow the ongoing upstream kernel development,
-which might create conflicting changes.
+dates or other non-technical reasons creates more work and burden for the
+involved developers and response teams as the patches need to be kept up to
+date in order to follow the ongoing upstream kernel development, which
+might create conflicting changes.
 
 CVE assignment
 """"""""""""""
@@ -275,34 +282,35 @@ an involved disclosed party. The current ambassadors list:
 
 If you want your organization to be added to the ambassadors list, please
 contact the hardware security team. The nominated ambassador has to
-understand and support our process fully and is ideally well connected in
+understand and support our process fully and is ideally well-connected in
 the Linux kernel community.
 
 Encrypted mailing-lists
 -----------------------
 
-We use encrypted mailing-lists for communication. The operating principle
+We use encrypted mailing lists for communication. The operating principle
 of these lists is that email sent to the list is encrypted either with the
-list's PGP key or with the list's S/MIME certificate. The mailing-list
+list's PGP key or with the list's S/MIME certificate. The mailing list
 software decrypts the email and re-encrypts it individually for each
 subscriber with the subscriber's PGP key or S/MIME certificate. Details
-about the mailing-list software and the setup which is used to ensure the
+about the mailing list software and the setup that is used to ensure the
 security of the lists and protection of the data can be found here:
 https://korg.wiki.kernel.org/userdoc/remail.
 
 List keys
 ^^^^^^^^^
 
-For initial contact see :ref:`Contact`. For incident specific mailing-lists
-the key and S/MIME certificate are conveyed to the subscribers by email
-sent from the specific list.
+For initial contact see the :ref:`Contact` section above. For incident
+specific mailing lists, the key and S/MIME certificate are conveyed to the
+subscribers by email sent from the specific list.
 
-Subscription to incident specific lists
+Subscription to incident-specific lists
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Subscription is handled by the response teams. Disclosed parties who want
-to participate in the communication send a list of potential subscribers to
-the response team so the response team can validate subscription requests.
+Subscription to incident-specific lists is handled by the response teams.
+Disclosed parties who want to participate in the communication send a list
+of potential experts to the response team so the response team can validate
+subscription requests.
 
 Each subscriber needs to send a subscription request to the response team
 by email. The email must be signed with the subscriber's PGP key or S/MIME
-- 
2.45.2


