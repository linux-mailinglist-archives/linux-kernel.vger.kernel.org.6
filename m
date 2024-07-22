Return-Path: <linux-kernel+bounces-258561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98479389C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AB91F2111F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D867450E2;
	Mon, 22 Jul 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="NbtEQAWq"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752054776A;
	Mon, 22 Jul 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632290; cv=none; b=dXqGse5+PUeN3BN1drGt/IyjlD3rCN58IhPagSvizK4M2+1iiRyW14Dj6Cq88jOkuEXM5YX5SC5LNztPjF8pEiqwVXmQ8xsyXGqD+yPVleUr3ph35EkgioyjxQOUAfaKzPY2dyFVAVmmGvfEN5RJFYy9/tpYiGRjk4xneqJ5zFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632290; c=relaxed/simple;
	bh=JxHI/ZiUCJ5QXwzrMpm6uDTvguA5MZRc5DcSL7YASww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHFl6vs8eqFcNhXUivCgz0lXwoBj8pfff09xrEyGic67uZFb8NGEX7CsEL1LyfQxvJuP0jge7UywBWn9Rn+LN03lGjc0iBVV8p9d5+V7Q9UPHKvxJ8wAPJ9lzn3r8awmP7ayDDgJF8K7KSkH/LfQ5Hz1wfgbNloTz9/2/hWQ1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=NbtEQAWq; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WSBKD3ZNQzDqXT;
	Mon, 22 Jul 2024 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1721632288; bh=JxHI/ZiUCJ5QXwzrMpm6uDTvguA5MZRc5DcSL7YASww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NbtEQAWqklXYEBxAnqmvheJ0hTfnMyI3zz9/wsitmOwQg1co/UfWEXtqGFgwxGAQP
	 ea4sIS9C8XBEn3e3VjfkUN2PC+8Q41I4c40daLXd7/zvdlq5mjfjvIb9jd8qw8+RYc
	 dCk6zaK3rYcphP5oaAgWWJmQfcS5lYd8R9zZi0wE=
X-Riseup-User-ID: 213644179A3551838FFA1B9669CE811AA9316FA9DF55FD16D9A56E01A59C661E
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4WSBK94kHwzJmqy;
	Mon, 22 Jul 2024 07:11:25 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 22 Jul 2024 14:10:18 +0700
Subject: [PATCH 08/12] arm64: dts: qcom: sm6115-pro1x: Update copyright
 year
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-qx1050-feature-expansion-v1-8-c4d486435b96@riseup.net>
References: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
In-Reply-To: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>

It's 2024, let's update the copyright year.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index a32fc27bc783..6e9e4d9f8250 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
+ * Copyright (c) 2023 - 2024, Dang Huynh <danct12@riseup.net>
  */
 
 /dts-v1/;

-- 
2.45.2


