Return-Path: <linux-kernel+bounces-313918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89496AC5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3F6285C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304BD1D58AF;
	Tue,  3 Sep 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWecsFhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC34168D0;
	Tue,  3 Sep 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403331; cv=none; b=BM2gnAyzIFtgzh6OtpHqPOzceHdZERbCBkVJZwgl+vtuC+xWkIhvvtY7jYFZW2oGNiql0QX5bOAaeL/XmTS8SMYchdUz2L7Lb0mTkeyVG0Q3P9naMQxxLB2dKdkz44fb8v4TJEgcuOeeDwPUiBHKIDvaMJEqJpdi0GnvERte3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403331; c=relaxed/simple;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J759adQN41UJkfuDjGn+48MpYeZgexQV+bdIR+y+a/7jw13hJR7/IsmJm6rEzBKeNdj1p48N+IUGgc1o57Mu6qD06J61Q/VJzqf+cMAulcZLnulSSP4YFa0vj8xdIpzHdQEUYojxrignZiOvdkddKlAsBMMyPccxZlfmrnnJ75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWecsFhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B0CC4CEC4;
	Tue,  3 Sep 2024 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403331;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:To:Cc:From;
	b=hWecsFhKcb5hKgr2Zbf39waj0EsKyDgVOOeWXR2uIPL0OVr134JSU0VfJZHP5luMZ
	 h06w/ooMqXh40aWOy7cA7WbpJgMpVylmD0FpASmD2VbQzqG4PlucqI6MaFgDmVhZZk
	 ezTMDBGTMIHskuazWFAZD+Lqincu6pCXWNDHOGwuE5v4MJv85APLIIYspLsJjTSbLw
	 8WB9iS1YiOtbUZAhodZCdzFBiJ6MasnN0l7mX0sENUDrecqHitUEGTDgR8OtdEIZAe
	 l1lVE2gV3Q8AENsENJKwQn5YOk3akqm4n9B1GNr2mOtec/E5tzXT/El+GR0/kwGXhG
	 DWX+VDhN/WVlQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Sep 2024 23:42:04 +0100
Subject: [PATCH] docs: submitting-patches: Advertise b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org>
X-B4-Tracking: v=1; b=H4sIALuQ12YC/x2MSQqAMAwAvyI5G2ituH1FPFQTNQertFUE8e8Wj
 wMz80BgLxygyx7wfEmQ3SXQeQbTat3CKJQYClWUqlUGaZ/OjV20MZk4lmjpYh9RN0pX3BiqqYV
 UH55nuf9zP7zvB0Jgfv1pAAAA
To: Jonathan Corbet <corbet@lwn.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm15DA3V3WbIDzC9rF85dCB+Znhf+FJAR45OkRk0vB
 ODoQ2VyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZteQwAAKCRAk1otyXVSH0GN4B/
 9xrtwhXmGjLg7TkmgsxfZksOG/aXyW6USgt0CDqcHV9Wxspv4npmdbcXtVbVdHy5CoRN5C5orP4Qqs
 9YJdoxI7lUjmrKzKRaK8jPOtTd1z0Vq9aSyF0C9OR78ZqQvpY5DmIFrtX+mVclouwChHQQF4CC0XnL
 ucM4NPbMAyh/wTDcyu76VN/DGfkbiJELZOWOQfk67PjZepPt34AIjdyhj/e1NrFkVDosYh22dCd/0B
 cJot9+R2eSOs0rEiUnI7Us9Du4Frwrq3qCj8Y23UJlcInY/brYIVB19F8uHQLQMUY2tDZGl73vYa23
 MW0GocFYfqr5coe0SouJCChDF+7+Qh
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


