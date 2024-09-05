Return-Path: <linux-kernel+bounces-317069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30C96D8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B8D1F23911
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8B19B587;
	Thu,  5 Sep 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU4jN9WW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D819885F;
	Thu,  5 Sep 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539971; cv=none; b=m4E+Dua46KvXS65IO6diE2CTotLkqXW3vrWQ2LKRee5B3msF55PZqEjm7NXYd/Ss2rj7Uu6bN6BN78hQIJwya+XkDDPPLErLYs1zya4kGa1KffmUX/qlONWlX9I1ckbE1XOOJuPEACLJ2Pg1A2WAvJlNKoaUWkq/+x+skSDh/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539971; c=relaxed/simple;
	bh=R9LFNUBxiOA+RKZaE/H7JwElegEOh582m+My/w1w5rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AM9NvczCvpStfGCpAhro6PsKdoc2WlShjfkmvuylqATBj2AvbjgAdLtl4iNdsuzz6YH/2szfHz8cfsotDb5FwPfryeLbNSNh6UUQDKPMIPIXFP/wmNRp5sdbXUNDAJ2v0MRK34qMQSYIs079dv6Ckj0/m4kff+KS0ogpFxhTFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU4jN9WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE8C4CEC3;
	Thu,  5 Sep 2024 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725539971;
	bh=R9LFNUBxiOA+RKZaE/H7JwElegEOh582m+My/w1w5rI=;
	h=From:Date:Subject:To:Cc:From;
	b=jU4jN9WWlbjjLXpCK10d8JeVLlLNSekynxoG7sJY1M6hbLTZ5W/qrlwlLIjrQIPoo
	 BMsT7YGZhNwTPv15dcMmMo1++dDUM/VhgRv2bCVr/PVyu5WCSeDLhlk2oXQv98lkP0
	 BYbFvwAFg1s709+YV3quZn8xcPSKEXW0cj7A86ozsjit7H46HR5i2jOeVcixhmtdvm
	 jN3x7Yph7nhPiYtf7tMx+gXNJhpPvNx9qc5LQ6u5Q3vEuqMWcvatt7JiOK8BFOpVrL
	 B9xyYCj+IE3lbjH1Mv2WCa1dYwLpBKZTGpWrxu/mTvt4podO1vP/g3yzlhfiBghTOX
	 0y4MEu5SOGOTQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Sep 2024 13:33:33 +0100
Subject: [PATCH v2] docs: submitting-patches: Advertise b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-documentation-b4-advert-v2-1-24d686ba4117@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByl2WYC/4WNTQ6CMBCFr0Jm7ZgWkB9X3sOwAGaARm3NtDYaw
 t2tXMDl9/Le91bwLIY9nLMVhKPxxtkE+SGDcentzGgoMeQqL1WrCiQ3vh5sQx9SE4cSe4osAXW
 jdMVNQTW1kNZP4cm8d/O1S7wYH5x89qOof+l/Z9SocWxaqqYTDfWgLzcWy/ejkxm6bdu+4Yk0W
 L8AAAA=
To: Jonathan Corbet <corbet@lwn.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=R9LFNUBxiOA+RKZaE/H7JwElegEOh582m+My/w1w5rI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm2aaA0DLE+SQVB1bPQTtTveTI1fApcTJXXf4NZo5c
 KCfwBPGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtmmgAAKCRAk1otyXVSH0M7nCA
 CElWoy/WN7Xm9leq6VPfWGEHqsgiQJH88UtjtJLe5ItIU35YGlFooRq2VhxbbVeJ1v44zZC0ROwEJc
 E6dzOzAL1QqPfVjgtJzwTVLIzgDnXzQRoGaRfe5j1wok3NOP0alfmoLO3iAwWNH9rOp/GM5O6jjVLr
 CQAHWG8buzz/HA/5EuI1LZBzip+ZompAabL0MlHqRbE4LlucoypJ6BmcPzu38ASwxPtXQZGSu305Xg
 5TCiBzewVK03a4OzV2KNkB8Wcffn1CcqfnQk/ePNVi5AkpWVL+32RbWFVsrmmgY2ac/j2c2aFM1kzX
 vKWF1Y14ZpjcXgWicMXDmnpNHrcUCh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

b4 is now widely used and is quite helpful for a lot of the things that
submitting-patches covers, let's advertise it to submitters to try to make
their lives easier and reduce the number of procedural issues maintainers
see.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Remove some blank lines.
- Link to v1: https://lore.kernel.org/r/20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org
---
 Documentation/process/submitting-patches.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index f310f2f36666..1518bd57adab 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -842,6 +842,14 @@ Make sure that base commit is in an official maintainer/mainline tree
 and not in some internal, accessible only to you tree - otherwise it
 would be worthless.
 
+Tooling
+-------
+
+Many of the technical aspects of this process can be automated using
+b4, documented at <https://b4.docs.kernel.org/en/latest/>. This can
+help with things like tracking dependencies, running checkpatch and
+with formatting and sending mails.
+
 References
 ----------
 

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240903-documentation-b4-advert-18016e83d7d9

Best regards,
-- 
Mark Brown <broonie@kernel.org>


