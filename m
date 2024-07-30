Return-Path: <linux-kernel+bounces-266932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E39409F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B32285152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040EB19004B;
	Tue, 30 Jul 2024 07:33:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D213B780
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324788; cv=none; b=R+vn0RK8/cjjYbtk1uS6z7fKB90Wcq2qnbhQGRtxb/fspzGtjKU4qHdXHHAr/zX9YASFxJ8vfuPggwQolSramV2UYX1zk+KN6lB69gATRIT1RptuF1bpgN2nahW1hSH+nOZkZxko2i7nrN5uuQt5/px2HaT8fSjzudHvDHL/7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324788; c=relaxed/simple;
	bh=bZmNkgXEILZ2YIp65MgOXVKj1+cOXwU33ukgOud5Lts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZLsqO/fLZ/+lIsoVwpSoHk4C0nSy/kWSOFgVID7JoqD0bCKE9ueAemTL41DvcpNHAAswqGbH21xZLpt85LSKMSRROSM/ssBohqRSN7nER71dS/nUiUJbpMJJP5UChxQE5P3XDS2ltpNTbbVB1gadwH71+h5ufaIrXtfTSTjoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYhLt-0004sW-UC; Tue, 30 Jul 2024 09:32:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org,
	ukleinek@debian.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/14] Expand available features on Qnap TS433
Date: Tue, 30 Jul 2024 09:32:56 +0200
Message-Id: <172232476458.2326272.436459219153385141.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jul 2024 21:55:24 +0200, Heiko Stuebner wrote:
> Thanks to the nicely supported rk3568, the hardest part for adding things,
> is to pull things from the vendor-kernel and translating them to mainline
> standards.
> 
> This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
> access devices connected to all 3 usb ports.
> 
> [...]

Applied, thanks!

[01/14] arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
        commit: e0ec6d48226fb3d4df18895b56f0b7a94c0fe474
[02/14] arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
        commit: 0f5f87a1d602a33028522784eb005647fa1b5c11
[03/14] arm64: dts: rockchip: enable uart0 on Qnap-TS433
        commit: 07ef8be476bebd77cba3ca4804be03cc0dba414f
[04/14] arm64: dts: rockchip: enable usb ports on Qnap-TS433
        commit: d992203f57c5caad0dbd4a9c669d79b315873c81
[05/14] arm64: dts: rockchip: add stdout path on Qnap-TS433
        commit: e1cb5d8a92e41171bf4d5ddc459bd96372500901
[06/14] arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
        commit: 673c1353b3d476b9c5df6b84a777ed171e5594f5
[07/14] arm64: dts: rockchip: add board-aliases for Qnap-TS433
        commit: dadd4256e12360d3ff1f6481b2e4697f9d890caf
[08/14] arm64: dts: rockchip: add hdd leds to Qnap-TS433
        commit: ea91aabf18bcad6f5eceae6848ea6570ea61f126
[09/14] arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
        commit: 2dfdddd9d20306fd0d04b88fcbbf36d76fb67f11
[10/14] arm64: dts: rockchip: add gpio-keys to Qnap-TS433
        commit: 9b682d31b24f1f70b5b4d0618095d46e0722b9d8
[11/14] arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
        commit: 99b36ba910d896bddbb9a190ca686c6d9cd0325f
[12/14] arm64: dts: rockchip: add missing pmic information on Qnap-TS433
        commit: ee078c7daa98353496410b715a5acbb41d7d3a90
[13/14] arm64: dts: rockchip: enable gpu on Qnap-TS433
        commit: 9130eb62586f4cef0557d0378fb7e78d7397ab2d
[14/14] arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
        commit: 64b7f16fb3947e5d08d9e9b860ce966250e45d52

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

