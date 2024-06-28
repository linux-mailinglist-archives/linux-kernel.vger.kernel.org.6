Return-Path: <linux-kernel+bounces-233795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFD91BD75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417D21F2305D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D66157E88;
	Fri, 28 Jun 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo4GRyb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44115698D;
	Fri, 28 Jun 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574223; cv=none; b=Z+Pqvsj8G8WZ2wG2POVE04AOrTBgFZLDicpGLupFw4TUjCFHIiwmXykYp3s4Ps3PhgV7tqVfgNk5ZXVZVoxKsVEZ6WA24ke5MbJCQKVveKkKQY7TAzAxa6U9NSjnzzMlZXwJ3JFjyHU2bbyRE5yt00/Sj+q4igPzRVb2Av8bpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574223; c=relaxed/simple;
	bh=et+SAxkVIgElX2sal84Jo2cUqRQRv9FUJKE5TREMKPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtVHcpUaeiN+maVs6aLkr2gnF+zjfmaCgKCsceXYbanjgtwdxGCqACysEVsqBBt8/7+Gklnqwcve5B2vjOv2uEpVa7KvR0C8Gd8a4JB7nsIjGkUQbk0dNJ3e+IcoD1z3XgCDIhpW0Cjh7ZxQKj+rGhnhxsb2hWJlIs0chCjvRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo4GRyb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41A98C4AF0A;
	Fri, 28 Jun 2024 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719574223;
	bh=et+SAxkVIgElX2sal84Jo2cUqRQRv9FUJKE5TREMKPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bo4GRyb5yofLBqL6MFDeZTxtWF56khi05KFV2L767q8o92yNuUA16PL2KOE6t0+pI
	 61C1ly/MPRp8x+GQyvqqj3dAYhLlzBX10fCKfcdTHXy37gu9MZgpAhi+pexgYpGMqu
	 gTyEdRnpKweNO1ycjqCQOmKU9spz8EtAQ3ib45XqoLwopeg2bTMbb9KjZYbm3ndieI
	 48FVIN3aSEy9pv4ixeGRUXmJd/Xhf+CMZBxZLSVHRWL8+9ZvzV+g5uSDFKeVCKlTS9
	 Td2A694KyMTXgj2QCV9ocqfYzMRPr1eZzWc97GHdbqBu5XVMgghGBc6Fz/D1u5LKN1
	 Ls9MAmDxjiQsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E742C30658;
	Fri, 28 Jun 2024 11:30:23 +0000 (UTC)
From: Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date: Fri, 28 Jun 2024 19:30:13 +0800
Subject: [PATCH 2/2] arm64: dts: qcom: Add device tree for ASUS Vivobook S
 15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-asus-vivobook-s15-v1-2-2a1e4571b8ab@gmail.com>
References: <20240628-asus-vivobook-s15-v1-0-2a1e4571b8ab@gmail.com>
In-Reply-To: <20240628-asus-vivobook-s15-v1-0-2a1e4571b8ab@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719574221; l=44317;
 i=wuxilin123@gmail.com; s=20240424; h=from:subject:message-id;
 bh=vCtW2uMKh5O0oVJS4GscOZI+FTtzMq+LEqzxH69+ViU=;
 b=wJS0B8u+pPt1xHvrYY+LioKUp9/6d9VT9tV/h0KCO5oM5+PKoZTvJj9resmHCiZqu+Ba+dkUR
 FsNwzDOf+uHDslpkod0VYNxwVjx/OuGf8c6YbF63gcVIGdsdabHHRmq
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20240424 with
 auth_id=157
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: wuxilin123@gmail.com

From: Xilin Wu <wuxilin123@gmail.com>

ASUS Vivobook S 15 is a laptop based on the Qualcomm Snapdragon X Elite
SoC (X1E78100).

Add the device tree for the laptop with support for the following features:

- CPU frequency scaling up to 3.4GHz
- NVMe storage on PCIe 6a (capable of Gen4x4, currently limited to Gen4x2)
- Keyboard and touchpad
- WCN7850 Wi-Fi
- Two Type-C ports on the left side (USB3 only in one orientation)
- internal eDP display
- ADSP and CDSP remoteprocs

Further details could be found in the cover letter.

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  | 515 ++++++++---------
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 613 +++++++++++++++++++++
 2 files changed, 871 insertions(+), 257 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5576c7d6ea06..dac4e19de654 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,262 +1,263 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
 
-apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
+# apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
 
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-schneider-hmibsc.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp474.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-gplus-fl8005a.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-harpia.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-osprey.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-surnia.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gprimeltecan.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandprimelte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt58.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5x.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-rossa.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-vince.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-huawei-angler-rev-101.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-msft-lumia-octagon-cityman.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-ivy.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-karin.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-satsuki.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-sumire.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-suzuran.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3t.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996pro-xiaomi-natrium.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8996pro-xiaomi-scorpio.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-hp-envy-x2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-lenovo-miix-630.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-cheeseburger.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-kb.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-kb.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r10.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r10.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-wifi.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd-pro.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-lenovo-tbx605f.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-enchilada.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-samsung-starqltechn.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-pipa.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-samsung-q5q.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-sony-xperia-yodo-pdx234.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-schneider-hmibsc.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp474.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-gplus-fl8005a.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-harpia.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-osprey.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-motorola-surnia.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a3u-eur.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gprimeltecan.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandprimelte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt58.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5x.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-rossa.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-vince.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-huawei-angler-rev-101.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-msft-lumia-octagon-cityman.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-ivy.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-karin.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-satsuki.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-sumire.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-suzuran.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3t.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-xiaomi-gemini.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996pro-xiaomi-natrium.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8996pro-xiaomi-scorpio.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-asus-novago-tp370ql.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-fxtec-pro1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-hp-envy-x2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-lenovo-miix-630.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-cheeseburger.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-kb.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r3-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-kb.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r9-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-kb.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r10-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r4.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r10.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r10.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel360-wifi.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd-pro.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-lenovo-tbx605f.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-enchilada.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-samsung-starqltechn.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-curtana.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-pipa.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-samsung-q5q.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-sony-xperia-yodo-pdx234.dtb
 
-sm8650-hdk-display-card-dtbs	:= sm8650-hdk.dtb sm8650-hdk-display-card.dtbo
+# sm8650-hdk-display-card-dtbs	:= sm8650-hdk.dtb sm8650-hdk-display-card.dtbo
 
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-qcp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
+# dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-qcp.dtb
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
new file mode 100644
index 000000000000..65cb3b0bd109
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024, Xilin Wu <wuxilin123@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "x1e80100.dtsi"
+#include "x1e80100-pmics.dtsi"
+
+/ {
+	model = "ASUS Vivobook S 15";
+	compatible = "asus,vivobook-s15", "qcom,x1e80100";
+	chassis-type = "laptop";
+
+	pmic-glink {
+		compatible = "qcom,x1e80100-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 123 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss0_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss0_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss1_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss1_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&edp_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_reg_en>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
+		vdd-l2-l13-l14-supply = <&vreg_bob1>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
+		vdd-l6-l7-supply = <&vreg_bob2>;
+		vdd-l8-l9-supply = <&vreg_bob1>;
+		vdd-l12-supply = <&vreg_s5j_1p2>;
+		vdd-l15-supply = <&vreg_s4c_1p8>;
+		vdd-l17-supply = <&vreg_bob2>;
+
+		vreg_bob1: bob1 {
+			regulator-name = "vreg_bob1";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob2: bob2 {
+			regulator-name = "vreg_bob2";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-name = "vreg_l2b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b_3p0: ldo14 {
+			regulator-name = "vreg_l14b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-l1-supply = <&vreg_s5j_1p2>;
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s4-supply = <&vph_pwr>;
+
+		vreg_s4c_1p8: smps4 {
+			regulator-name = "vreg_s4c_1p8";
+			regulator-min-microvolt = <1856000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		vdd-l1-supply = <&vreg_s1f_0p7>;
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s4c_1p8>;
+		vdd-s1-supply = <&vph_pwr>;
+
+		vreg_l1d_0p8: ldo1 {
+			regulator-name = "vreg_l1d_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2d_0p9: ldo2 {
+			regulator-name = "vreg_l2d_0p9";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3d_1p8: ldo3 {
+			regulator-name = "vreg_l3d_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
+
+		vreg_l2e_0p8: ldo2 {
+			regulator-name = "vreg_l2e_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3e_1p2: ldo3 {
+			regulator-name = "vreg_l3e_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		vdd-l1-supply = <&vreg_s5j_1p2>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
+		vdd-s1-supply = <&vph_pwr>;
+
+		vreg_s1f_0p7: smps1 {
+			regulator-name = "vreg_s1f_0p7";
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-6 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "i";
+
+		vdd-l1-supply = <&vreg_s4c_1p8>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "j";
+
+		vdd-l1-supply = <&vreg_s1f_0p7>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s5-supply = <&vph_pwr>;
+
+		vreg_s5j_1p2: smps5 {
+			regulator-name = "vreg_s5j_1p2";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1j_0p8: ldo1 {
+			regulator-name = "vreg_l1j_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2j_1p2: ldo2 {
+			regulator-name = "vreg_l2j_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3j_0p8: ldo3 {
+			regulator-name = "vreg_l3j_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+    /* PS8830 USB4 Retimer? @ 0x8 */
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+    /* PS8830 USB4 Retimer? @ 0x8 */
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	keyboard@3a {
+		compatible = "hid-over-i2c";
+		reg = <0x3a>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&kybd_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+
+    /* EC? @ 0x5b, 0x76 */
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+    /* PS8830 USB4 Retimer? @ 0x8 */
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp3 {
+	compatible = "qcom,x1e80100-dp";
+	/delete-property/ #sound-dai-cells;
+
+	status = "okay";
+
+	aux-bus {
+		panel {
+			compatible = "edp-panel";
+			power-supply = <&vreg_edp_3p3>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_dp3_out>;
+				};
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+			mdss_dp3_out: endpoint {
+				data-lanes = <0 1 2 3>;
+				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+};
+
+&mdss_dp3_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&pcie4 {
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l3j_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie6a {
+	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie6a_default>;
+
+	status = "okay";
+};
+
+&pcie6a_phy {
+	vdda-phy-supply = <&vreg_l1d_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&qupv3_0 {
+	status = "okay";
+};
+
+&qupv3_1 {
+	status = "okay";
+};
+
+&qupv3_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/x1e80100/ASUSTeK/vivobook-s15/qcadsp8380.mbn",
+			"qcom/x1e80100/ASUSTeK/vivobook-s15/adsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/x1e80100/ASUSTeK/vivobook-s15/qccdsp8380.mbn",
+			"qcom/x1e80100/ASUSTeK/vivobook-s15/cdsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&smb2360_0_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l2b_3p0>;
+};
+
+&smb2360_1_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l14b_3p0>;
+};
+
+&smb2360_2 {
+	status = "disabled";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <34 2>, /* Unused */
+			       <44 4>, /* SPI (TPM) */
+			       <238 1>; /* UFS Reset */
+
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio70";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	kybd_default: kybd-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		bias-disable;
+	};
+
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie6a_default: pcie2a-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie6a_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+		    pins = "gpio154";
+		    function = "gpio";
+		    drive-strength = <2>;
+		    bias-pull-up;
+	    };
+	};
+
+	tpad_default: tpad-default-state {
+		pins = "gpio3";
+		function = "gpio";
+		bias-disable;
+	};
+};
+
+&usb_1_ss0_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l2j_1p2>;
+
+	phys = <&smb2360_0_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_1_ss0 {
+	status = "okay";
+};
+
+&usb_1_ss0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_ss0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss0_hs_in>;
+};
+
+&usb_1_ss0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+};
+
+&usb_1_ss1_hsphy {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l2j_1p2>;
+
+	phys = <&smb2360_1_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_1_ss1 {
+	status = "okay";
+};
+
+&usb_1_ss1_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_ss1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss1_hs_in>;
+};
+
+&usb_1_ss1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+};

-- 
2.45.2



