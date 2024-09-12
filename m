Return-Path: <linux-kernel+bounces-325847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C93975EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E61281ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681041C89;
	Thu, 12 Sep 2024 02:32:32 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466746BF;
	Thu, 12 Sep 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108351; cv=none; b=KsUSw5aCNmK8pZAtUW2JyAaR/bQUbfBKeqVWqpQpQ8TaKqtMx471ZruobVkxgxuMS3TeE8fcjJEmecSI2xQAvGx1gHoEyc4T9bLd3NdoSWvPIX68qUQDupT7VqyCvcnKBNXNabJdvfDoFkSNn1qI1FoT9FngGzcLyXQkkeNFXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108351; c=relaxed/simple;
	bh=ZmUjudHiyuEWMBzCozWoAuZie6RwccvbeHh4MzHt5nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/9lMNEM/YjbH5WOy3ZS3pVXVa7c5woYqV9iAZPfaUoNvjA/Uvt2+MnPs10J/3Jli8SBWpwlRlo9RwlqQwmwLedjU8KM7uHoA+tf/BHPMUvo2pPnHjgKgG078oCKJUzerpQgqOchhAuJhXTyZaMIkUTi7N4bFzIefkw7KPc2les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c02:fc40::1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8786E7E0187;
	Thu, 12 Sep 2024 10:30:22 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Thu, 12 Sep 2024 10:30:18 +0800
Message-Id: <20240912023018.23986-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911122809.1789778-5-bigfoot@classfun.cn>
References: <20240911122809.1789778-5-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkNDVkkeTRgYQk0dSR9OQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtJQR0YT0tBQUpZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
X-HM-Tid: 0a91e411456003a2kunm8786e7e0187
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDY6Thw6TjI0Ti0jLUMKNRE4
	OAkaCUJVSlVKTElNSktDSUlISU1JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0lBHRhPS0FBSllXWQgBWUFKQkxLNwY+

Hi Junhao,

> ...
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> ...

> +	rfkill-modem {
> +		compatible = "rfkill-gpio";
> +		label = "M.2 USB Modem";
> +		radio-type = "wwan";
> +		reset-gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
> +		shutdown-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
> +	};

gpio0 RK_PB0 conflicts with xin32k, please add:

&xin32k {
	pinctrl-names = "default";
	pinctrl-0 = <&clk32k_out1>;
};

> +	vccin_5v: regulator-5v0-vcc-in {
> +	vcc_sysin: regulator-5v0-vcc-sysin {
> +	vcc_syson: regulator-5v0-vcc-syson {
> +	vcc5v0_usb30_otg0: regulator-5v0-vcc-usb-host {

obviously (

-- 
2.25.1


