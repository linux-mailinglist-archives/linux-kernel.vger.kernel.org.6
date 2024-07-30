Return-Path: <linux-kernel+bounces-266933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BA9409F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C780EB23582
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7F190051;
	Tue, 30 Jul 2024 07:33:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7241667ED;
	Tue, 30 Jul 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324788; cv=none; b=f+mzkM4mLgLPRUGPpsRXSAt0yDRt2ooEmmVxUCYKjbf7O5OkLWY/LJc3W1cvKlPlHQo6oyhB32rJ1TIyTc8g/pWQTW4hMrJVCTGbcaiNF9V+Al+KmzTzV8Qqa+LssNjUSi20kIscd51Axk3IXZy1FU4stvY6PPpQur1X8SrT55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324788; c=relaxed/simple;
	bh=+3agwb1Di/PPJuq3Up9Jxz1a9/mMKx0J70W8UMFXSys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGdcg/GsSizcBwt/UDnXJx8zLMHXtYc+T9FdjZmAtgf/IPYA+jFXe5plONu0WVWQ7SWJKlJ15GL5uPudmEoWCLs1eIrwQThs2kHBk+X9G/MwyeUhnsRZ5wwBFFHHS3l3ykqdnpGuyMvI47tpcPwwhZYWpUaG/PROVipYn62i908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYhLt-0004sW-JH; Tue, 30 Jul 2024 09:32:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC variants
Date: Tue, 30 Jul 2024 09:32:55 +0200
Message-Id: <172232476460.2326272.7433810952292381571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <9417b5c5b64f9aceea64530a85a536169a3e7466.1721532747.git.dsimic@manjaro.org>
References: <9417b5c5b64f9aceea64530a85a536169a3e7466.1721532747.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 21 Jul 2024 05:45:16 +0200, Dragan Simic wrote:
> Rename the Rockchip RK3399 SoC dtsi files and, consequently, adjust their
> contents and the contents of the affected board dts(i) files appropriately,
> to "encapsulate" the different CPU and GPU OPPs for each of the supported
> RK3399 SoC variants into the respective SoC variant dtsi files.
> 
> Moving the OPPs to the SoC variant dtsi files, instead of requiring the
> board dts(i) files to include both the SoC variant dtsi file and the right
> OPP variant dtsi file, reduces the possibility for mismatched inclusion and
> improves the overall hierarchical representation of data.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC variants
      commit: 296602b8e5f715d6a0ccdcd37d57170c2c81d5e4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

