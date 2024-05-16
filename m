Return-Path: <linux-kernel+bounces-181254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A38C7994
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CA91F214EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE99414D43A;
	Thu, 16 May 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1c9GRxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CA143742;
	Thu, 16 May 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873738; cv=none; b=fib4TlPJxD+6qfC9oSjOvBPkKeydIQI1OqCJ9h5JplED7PtLFpYi9OX44O35uqzNGRxSnB4edxiS/dmATqIOFFIfTDHr9nLOX3gbYIhDKJMDe3x76NvpRWvvjGu6wBp/3NVGGxAeYYwxXjWdBF8eWBo81Ecz5A9hbft5oTgDwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873738; c=relaxed/simple;
	bh=boigR5gIZt1l3iH3GtoCwCGGLzHlg2JcL2p9c34ACho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjHWZPnL9qyX1QaCWL1fyR8F4yvnSUtAUMt1bpEpjauctqeUdAUkB5Dav1jEbwXWCTnVyq28O2vaGUPuQufab9IkCRxS+pn3LRLxAJ0ngQO1Xr+66mBQRP8KGaNAo/O4zC50pekD544AYo3tFPbM6naezn1qnWLg1ky8r/GUkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1c9GRxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E55C32786;
	Thu, 16 May 2024 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873737;
	bh=boigR5gIZt1l3iH3GtoCwCGGLzHlg2JcL2p9c34ACho=;
	h=From:To:Cc:Subject:Date:From;
	b=g1c9GRxX6kyhf56VhAunein55+1zzfEdNt5tkoyyeKDFXL6oIGAocUHwnLqrFigF1
	 +qRzMUuxXsnKPhs5QfeYoBGSrNnygUWmFIv6ZePbaPgw+BO+fvY7xDn9ime1wzWf8w
	 VJq32ZXKFX7PGrpARqVmNNtfSKWW96SzfdLmE7oC3mxRhPakIXnHZCVGkOGbXRFlKH
	 2QA1npLwCMnjif7hJqJmlP6WXgU6Vu/HHOZywQM97EkT586ZcVRF7L9G+mb9WlwWhi
	 e1gKOBIM3odwV/FGxLEkdICN0bAYpPL/V8o5guTme3NNZNT4tBSYsvlNKmbfRmAOHN
	 gyAREyrHTvoUQ==
From: Conor Dooley <conor@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	kanakshilledar111@protonmail.com,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Documentation: process: Revert "Document suitability of Proton Mail for kernel development"
Date: Thu, 16 May 2024 16:35:23 +0100
Message-ID: <20240516-groin-slingshot-c3c3734d2f10@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=v+xfzO8GI7HLpGSyhVZ+VeIne0y5NTb84uSoqgEU23Q=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlu6rvdGbe95rghuyvlqW/2mlL9w5u6p5xqybu5OSqWq bBmjt7SjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExE2Yrhn776dH8u4+xXd9W2 ZtkUPPoaf61p6SvO0N9vru+ynx3Y38jwh6/TvFPn/3Mn6VTvU+HzalWuPzs7T1c2LN/cP/tJqyE HJwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Revert commit 1d2ed9234c85 ("Documentation: process: Document
suitability of Proton Mail for kernel development") as Proton disabled
WKD for kernel.org addresses as a result of some interaction with
Konstantin on social.kernel.org

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

I tried to find the stuff on social.korg to provide a link
but could not.

CC: kanakshilledar111@protonmail.com
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC: Mark Brown <broonie@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/process/email-clients.rst | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index 471e1f93fa09..fc2c46f3f82d 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -350,23 +350,3 @@ although tab2space problem can be solved with external editor.
 
 Another problem is that Gmail will base64-encode any message that has a
 non-ASCII character. That includes things like European names.
-
-Proton Mail
-***********
-
-Proton Mail has a "feature" where it looks up keys using Web Key Directory
-(WKD) and encrypts mail to any recipients for which it finds a key.
-Kernel.org publishes the WKD for all developers who have kernel.org accounts.
-As a result, emails sent using Proton Mail to kernel.org addresses will be
-encrypted.
-Unfortunately, Proton Mail does not provide a mechanism to disable the
-automatic encryption, viewing it as a privacy feature.
-The automatic encryption feature is also enabled for mail sent via the Proton
-Mail Bridge, so this affects all outgoing messages, including patches sent with
-``git send-email``.
-Encrypted mail adds unnecessary friction, as other developers may not have mail
-clients, or tooling, configured for use with encrypted mail and some mail
-clients may encrypt responses to encrypted mail for all recipients, including
-the mailing lists.
-Unless a way to disable this "feature" is introduced, Proton Mail is unsuited
-to kernel development.
-- 
2.43.0


