Return-Path: <linux-kernel+bounces-313912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4896AC46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1DEB23829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303011D588D;
	Tue,  3 Sep 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5R+NXJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418C186E30;
	Tue,  3 Sep 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402980; cv=none; b=rWIJAAQtNGGakbrFMrEaZZYkS5AAQZBZBtkk3JLWHv7Cuv1KDeGdDTQXRjF/C8yWBod6WSikD8VB0IkUlpwkHb3+j4G8Pdhi6EU1FV1ofk00aCnHWFgM61nbA6ENJf99dMtv21c8ZQ45Bx7xHASjsMVje78NMxmwCE+VCnpaCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402980; c=relaxed/simple;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CFGrH3IvPadOYdGlQCvSb6AoB85PGBcv50Hkwf/XILmLUz/LMRbn5sG1+FvImHxNDxs1yVh63aubDei6/gqIaRrdQg5viBlIE03kbnL34mSJu6ZvIt/6cLUY1zkPe5iKqmlWXXESnuJ/ve5IPv6nOtKRNbELDXwohfvhruPHkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5R+NXJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4352C4CEC8;
	Tue,  3 Sep 2024 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725402980;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:To:Cc:From;
	b=t5R+NXJS7ceShRs5loYLB1GbvWLXbsTSNwqzcUeDuydzHOh7yXDdEjWCVIk/w6I5C
	 /gmhl6SklRud24waZ0HbxfJCHGjV88AcA9RhIEMrlA+mbbY92TdWOpwCCXS4mQWXp/
	 e0YX2AkrQ2HMId9xKxOe1C6gxvod6kDEsfeaLBpemCwWBSrwV6XMO4Wlqs6Sml0wdi
	 exY1zDRT0KU+Jwjqta8a8eFtmSs9Q+cn1UGua9vxKBnACT8ehM87khBi1rReo6P16U
	 gkE8OKVzDL0o6iSNCmBZonoH3cm9PufHX7+h34nWTQd5/ZL8rAVeMRk3nydUB6shiK
	 Dq2eXldJs9bpA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Sep 2024 23:36:02 +0100
Subject: [PATCH] docs: submitting-patches: Advertise b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-documentation-b4-advert-v1-1-fefda9564f6e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFGP12YC/x2MSQqAMAwAvyI5G2ituH1FPFQTNQertFUE8e8Wj
 wMz80BgLxygyx7wfEmQ3SXQeQbTat3CKJQYClWUqlUGaZ/OjV20MZk4lmjpYh9RN0pX3BiqqYV
 UH55nuf9zP7zvB0Jgfv1pAAAA
To: Jonathan Corbet <corbet@lwn.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm149hGmuOSz86kPMz+k+68HRFxU7pTuCXgJZNW/bF
 jfGhiMyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtePYQAKCRAk1otyXVSH0EJ3B/
 wLEanakrcIqqBQ+MCRwUOAboiatcaAx++AoH3bJPKIA7bBUfKIzyLWb9CCi6EdsMJahDPYfoNTLtxt
 kwQ3VUa4ujOoe+xVz9tngXnuWHABvMhaEbTjImjmYIU20rH3QhkxiVGMCQ8UiLxeEMIK4xiNqeoY0m
 aI9Ru0VBU/ZKHe8n9xo3BphKw7+WFpSIuZymfv3MEgqByK0O1KCQi0Tl/m9JziIMPrX1C/bs3VWQZi
 v8cAN+tvrfydUL83MqTn0aYwRVhlUTRHFnL2SyigvCiwSCuTFBgtvpZoNCKfkT2e8oHNz2nOW6huio
 OGY1r8QpYsc9JMaUn7wH4r/tEfbw0C
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

b4 is now widely used and is quite helpful for a lot of the things that
submitting-patches covers, let's advertise it to submitters to try to make
their lives easier and reduce the number of procedural issues maintainers
see.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/process/submitting-patches.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index f310f2f36666..4b6904184ad1 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -842,6 +842,16 @@ Make sure that base commit is in an official maintainer/mainline tree
 and not in some internal, accessible only to you tree - otherwise it
 would be worthless.
 
+
+Tooling
+-------
+
+Many of the technical aspects of this process can be automated using
+b4, documented at <https://b4.docs.kernel.org/en/latest/>. This can
+help with things like tracking dependencies, running checkpatch and
+with formatting and sending mails.
+
+
 References
 ----------
 

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240903-documentation-b4-advert-18016e83d7d9

Best regards,
-- 
Mark Brown <broonie@kernel.org>


