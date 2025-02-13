Return-Path: <linux-kernel+bounces-512879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE08A33EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8493162DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48B221574;
	Thu, 13 Feb 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElRnAjM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03421D3EE;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448388; cv=none; b=SopNSy5e95MPOlXtjH7RVGkPofmMnDovz1iIm0Vrm39FV2VwYVvgc00S81rNZbu26qQbT5gwWHOiqLNicmzsa7muHpvE3bhC5lQGhxWzAgbX+K0Yde/8cMHvOLveVYT8jq3ZQWLnbQ9aIVsy1GGxwdM4V03HcMzp+QF/5Ib2o0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448388; c=relaxed/simple;
	bh=/Amj8QMX4cjKrM7YxDVeFIGaF99CFoJ+BqTe2Cuk59w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvXMpcAxVHlqixuwFLrT3Qz0dg93j/1bqvrtjUKeMypNeG5bhWX0QeI2nf07B1ToegPSOYAeP1mQ5K9nC/KI4HozW/I2YcyyRwvNsEUYcCNZk4QQSYQEj2nPpjdSY4KE3sRw2aE7gdJEsytXd3u5Fz/yshskD7CRZG1Q3UsI/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElRnAjM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B54C4CEE6;
	Thu, 13 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739448388;
	bh=/Amj8QMX4cjKrM7YxDVeFIGaF99CFoJ+BqTe2Cuk59w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElRnAjM2qTYuEjtNgrjahFrZky1+vAlgWHIzeNs2dRnH3ZrchN4ZXMvj33cy0cO7J
	 E43J81Q09oOxmkByjIRViVA7LUo2WQKUdp5v9k+5BLTawTsYFYfHpYVT8+rekwzOl5
	 eLNGHi9dFq3BEORWJo6/fjzSNqWaMLjza/lxWr2p6WwwzkNvrriy1NLGpqt7CynTAw
	 Zwao8IB2d0MDmLOUXOj3qc+n+khKSgpSr8vCwvCsvaUyKYtpKtwImSdBBozVPxLcag
	 g4h0tTfvRqmpJfcZe41+/fS2Z3KjoUOMarp6dvtBQYpw20kH88Syvb++iRLSFhogV3
	 0p6ttRaX108+w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiXz7-0000000BIVC-1bq7;
	Thu, 13 Feb 2025 13:06:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFCv2 3/5] scripts/kernel-doc: don't add not needed new lines
Date: Thu, 13 Feb 2025 13:06:16 +0100
Message-ID: <5b5017631b7499d53c4da9ff9b0288eb0d1f914d.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This helps comparing kernel-doc output with the new .py version
of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 70da9a3369c6..0dfee1c3d365 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -816,6 +816,10 @@ sub output_highlight_rst {
     if ($block) {
         $output .= highlight_block($block);
     }
+
+    $output =~ s/^\n+//g;
+    $output =~ s/\n+$//g;
+
     foreach $line (split "\n", $output) {
         print $lineprefix . $line . "\n";
     }
-- 
2.48.1


