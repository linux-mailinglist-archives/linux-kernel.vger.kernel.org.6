Return-Path: <linux-kernel+bounces-313913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDABF96AC4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE7C1C216A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC11AD27E;
	Tue,  3 Sep 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js9mVu9a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61677186E30;
	Tue,  3 Sep 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403092; cv=none; b=B779atL8rPDm7SvVLwklQQEfr5MeI0RYhxunYI5epMH2q30Lh0PUD2alo8CtPIwBBLDfLmNfE19pFAwV80SeF+de4Oj4eK/j/K3dqsoJlG9uL/+KC00AxwF792+y9Vwy0RVB/mqxrWaXycnXAbyCzhQOrbr+kyYxTZyoiw3hb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403092; c=relaxed/simple;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HFEugnVhqlyrs1L+OZFrhwKddlu/CsR9LoBKvvAykrpB2a1O7zSQT5PH08QO4am/iTsVP6encdW2mB8WkQc+KFt4BC0MvUGSpPMU8oJNNeykQ/mYaz0wgTN2A8EH5Tm7I/vAi1W0jDyLt8Pxdw7C1OqCCPM/2X1NbPL6ytc2d/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js9mVu9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB091C4CEC4;
	Tue,  3 Sep 2024 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403091;
	bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
	h=From:Date:Subject:To:Cc:From;
	b=Js9mVu9a8u/+cmujqFR7xOPBihvqEnPyK693pFRW3cU+NuDq3UxLuQaL4TYJlPl0y
	 fNW81TQr5B7TJ20NM5annc2UVTM3z5c1GJon5kSjRPqdNTQcXM/lNCqHGQiiTWcoMp
	 DsmjnRmk850ICIf0qRWk8kNRGApiNi73r4skBMmpZQAnlcmO69TscQs58BmYo6ytVZ
	 WznTpRH6bDkQ7nV7XbcDoHgBNbivrRYqLr4sdFlT4kw5DvAeyNtsgJJr8wes6dpx5q
	 dFizdK15jr6t5PAdEFAdGM+xGT4dijqyMTj0O4HtzTeVqXv+MxB2NQVqek4L36xhfO
	 6m7Sj+6pfUduQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Sep 2024 23:38:06 +0100
Subject: [PATCH] docs: submitting-patches: Advertise b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-documentation-b4-advert-v1-1-7415cdd74813@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM2P12YC/x2MSQqAMAwAvyI5G2ituH1FPFQTNQertFUE8e8Wj
 wMz80BgLxygyx7wfEmQ3SXQeQbTat3CKJQYClWUqlUGaZ/OjV20MZk4lmjpYh9RN0pX3BiqqYV
 UH55nuf9zP7zvB0Jgfv1pAAAA
To: Jonathan Corbet <corbet@lwn.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w/F5Gln/VAy+w+5IKZ0bm6juyWi5rGx8h9yXwrhxeU8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm14/RatF8H8chJ2oOyOjfR1PuV/tTK+c79PSfzLSx
 tA8jTeyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZteP0QAKCRAk1otyXVSH0CiZB/
 9EIt50HFKQFbJFNGFAX3ENCezy0hpdKlq6eDsiMAX0HPgrgie8LNy52qPsNwQgZvEr//GXy3rD2IdZ
 +NLFtPV7AdFBw7Tv2fZD+NYq2ErTjbNqFJFWSYVppiQZL+ghTjQetA/g6AScHuZbOEKZvCkvOkdPnE
 BG8nzwoN0oUqRkSI3ITMmfHzKFtqa8MkzbsngQ7rD+b5vJuflcTQ97zD9Rt76k0Y5MgUDw59qm/W7V
 yGCm3voD3djFHV9TxyZhxLwX7bjB4vJbsDyBC2edzc7EAlauxZvfxnV+WG/5htibuFtODTqwSPRyaB
 Y1Zx/q7CnAfz16AJN/lI15SAbtPy0e
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


