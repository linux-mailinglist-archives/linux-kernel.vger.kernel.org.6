Return-Path: <linux-kernel+bounces-399387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047BC9BFE54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273551C20953
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829F1953BD;
	Thu,  7 Nov 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGHtJepk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23B18E379;
	Thu,  7 Nov 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960210; cv=none; b=NUs3CJLi1Wmt+WOuwAjQVkyLcpmlWlFuxmC7AU1sz5k1PZYZipuwF5Iswpz/RbldHB8YuGu0HKB9iN7aAa874Rxt21TLR40+gCPERXf03GySZ5WemUFv51ls3618f2u8n6wv9EjtGMXY3/KrPNp9JB1GUQm4z8IUHCCG2FwwuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960210; c=relaxed/simple;
	bh=hRZ6R9XGg0C09TZAwpxZbnEHKBb4TEY7MB4O1hSHSzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UoexAcFhVYnlsb/czi9KUF1tYr4hovhGjVXbv6rz5ZO04dMZ5ssR4UfTWTQuagyAhRk6vNLw3/aNMfe6UQZrkNUWJFkrCX3NINbEanaqoClGBcCprTOCPgq3W15RAEl3hsStDlDjkH8wBzxAdz5i5GW4SD/3gk/xZeXUVor+5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGHtJepk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53223C4CECC;
	Thu,  7 Nov 2024 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730960210;
	bh=hRZ6R9XGg0C09TZAwpxZbnEHKBb4TEY7MB4O1hSHSzA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tGHtJepk8cg1QaPVLK5koS6Q29kL86ViLTjV8uB/iJC5Q5ETBDkmCv21pqw+sGOfY
	 /58Iu/rXKPuRGHIcgqtHv925CFCslzD13AU5gvdG8m6UqbV+IRhQE1UxUOiZCGOKQD
	 E0LR0G8QbBxEE1B0ESmy7TsD5HT+yrmIvK39Q8yqiyZEHfNBj76IP6hXBq4ZQbkLp3
	 zsBI/gUNxZgrRxgTRGoFBWVTFDGCsTOk1M7laMeDPO5WmOXswerARqr4VZV6Dgxwx1
	 vSYbywQxEmsS8w8AdFTa7PXQtg/nOjdRDEkV5Lw6zIPEhIl2IrZ8WppB6nvCGdR2GE
	 +rKhnMzllZSDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFFED5AE68;
	Thu,  7 Nov 2024 06:16:50 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Subject: [PATCH v8 0/3] arm64: dts: qcom: sc8280xp-blackrock: dt definition
 for Windows Dev Kit 2023
Date: Thu, 07 Nov 2024 07:16:46 +0100
Message-Id: <20241107-jg-blackrock-for-upstream-v8-0-0305621f17f2@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5bLGcC/43SzU4DIRQF4FdpWHsNXKCAK9/DuGD4abHT0sB0o
 jZ9d5lZaDeSLg8JHycnXEkNJYVKXjZXUsKcasqnFvTThri9Pe0CJN8yQYqCGqTwsYNhtO5Qsjt
 AzAUu5zqVYI+gnLLOIg2aI2n3zyXE9Lnab+8t71Odcvlan5rZckpklEKrwCAIqUFYbsFGiuAkB
 kmdZWYrXvPoq9vnPNY8XqbWrz4P6Zss5Iwr80C5GYGCGSJGNiAzzHVZ/ssyyniP5Y3V3HguNLc
 6qC4r7lhUPVY0VlE+oBTRGRm7rLxjeXcEubalznAtuLK+y24fZrdLW+dVVF57o/rbqj+2jdtj1
 dIWjQymfRPpzb/s7Xb7Aca+TljJAgAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Merck Hung <merckhung@gmail.com>, 
 xlazom00@gmail.com, Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730960208; l=6104;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=hRZ6R9XGg0C09TZAwpxZbnEHKBb4TEY7MB4O1hSHSzA=;
 b=Qqo3GKpmQtkj2guCSnQInzHuRW1wy3aJiM+dtgNYDhAeKcg4YrVLof/tX3k8cGD95J3xw3yjy
 Bry+VsijwTvBB47bxBdjL0Q769K7SElBg8PMqC/1ZRhlh7lfeuo4+t5
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

"Microsoft Windows Dev Kit 2023" aka "Blackrock" aka "Project Volterra"

Device tree for the Microsoft Windows Dev Kit 2023. This work
is based on the initial work of Merck Hung <merckhung@gmail.com>.

The Windows Dev Kit 2023 is a nice little desktop based on sc8280xp.
Link: https://learn.microsoft.com/en-us/windows/arm/dev-kit/

Supported features:
- USB type-c and type-a ports
- minidp connector
- built-in r8152 Ethernet adapter
- PCIe devices
- nvme
- ath11k WiFi (WCN6855)
- WCN6855 Bluetooth
- A690 GPU
- ADSP and CDSP
- GPIO keys
- Audio definition (works via USB)

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Original work: https://github.com/merckhung/linux_ms_dev_kit/blob/ms-dev-kit-2023-v6.3.0/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-dev-kit-2023.dts

This dt is more or less deducted from the Thinkpad X13s.
It contains a lot of guesswork, and also a lot of research on
what works with the Windows Dev Kit.

The WiFi definition references qcom,ath11k-calibration-variant = "MS_Volterra"
which is unfortunately not yet in the linux-firmware. The ath11k driver finds
the default one for 
"bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2|18,qmi-board-id=255"
when the entry with the variant is not found which is quite sub-optimal. I 
have placed a pr on github/qca-swiss-army-knife:
https://github.com/qca/qca-swiss-army-knife/pull/9 that provides an amended 
board-2.bin and a board-2.json to generate it. 

It is in use and under development since May 2023, pretty stable now.

---
Changes in v8:
- Re-checked and amended the usb_2_dwc3 definition as pointed out by Krishna.
  Reduced the usb_2 ports used to one, with usb_2_hsphy0 and usb_2_qmpphy0 as 
  phys. Removed all others from the definition. Apparently there is a 4 port
  hub on this port, with the r8152 ethernet adapter on port 001 of this, the
  other three are the external connectors.
- Removed max-link-speed = <4> from the pcie2a node. The cap warning is shown
  regardless.
- Link to v7: https://lore.kernel.org/r/20241101-jg-blackrock-for-upstream-v7-0-8295e9f545d9@oldschoolsolutions.biz

Changes in v7:
- re-checked and amended the usb_2_dwc3 definition as pointed out by Krishna. 
  The SoC definition already has most of it, reduced to enable node and pinctrl
- re-worked the sound definition - this box has no mics or speakers or jacks 
  for them AFAIK. There needs to be something done regarding Soundwire on DP, 
  but this isn't working yet.(Konrad)
- rebased the patch onto <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
  and updated wcn-6855-pmu accordingly. (Konrad)
- re-sorted the pmc8280_1_gpios (Konrad)
- removed the gpio-reserved-ranges since I don't know what they are for. Best I 
  could do is refer to the X13s dt, but it's not the same hardware. (Konrad)
- ath11k: opened a bug https://bugzilla.kernel.org/show_bug.cgi?id=219454 
  to add the board id with variant to board-2.bin
- Link to v6: https://lore.kernel.org/r/20241030-jg-blackrock-for-upstream-v6-0-7cd7f7d8d97c@oldschoolsolutions.biz

Changes in v6:
- added missing acked-by tag from Krzysztof
- removed aspm-no-l0s from the PCIe ports as suggested by Johan
- corrected max-link-speed to <4> on PCIe2 as suggested by Johan
- changed WLAN variant description to "MS_Volterra", added Kalle Valo 
  for approval / guidance
- trimmed the supply statements on hsphy and other pcie ports for what 
  is known and defined on the Thinkpad X13s
- Link to v5: https://lore.kernel.org/r/20241030-jg-blackrock-for-upstream-v5-0-830c938437ad@oldschoolsolutions.biz

Changes in v5:
- removed s-o-b from Merck Hung as suggested by Bjorn Andersson. The credits
  for the original work are in the cover letter and in the dts commit
- removed Venus codec from the list of supported features. It is, but that
  part is not in this patch set.
- Link to v4: https://lore.kernel.org/r/20241027-jg-blackrock-for-upstream-v4-0-703b254fc95f@oldschoolsolutions.biz

Changes in v4:
- removed the redundant regulator definitions
- changed the pinctrl property order
- use microsoft instead of MICROSOFT as subdirectory and device name component
- amend spacing in audio nodes
- change external connector dp1 for mini-dp to DP-3 for consistency
- Link to v3: https://lore.kernel.org/r/20241013-jg-blackrock-for-upstream-v3-0-839d3483a8e7@oldschoolsolutions.biz

Changes in v3:
- tried to heed all advice and comments given - thank you
- re-ordered patches to definition before use
- added "microsoft,blackrock" as compatible in QSEECOM driver
- removed the qseecom node
- ordered nodes alphabetically {address, node name, label}
- amended indentation
- consistently used blackrock as identifier / directory name
- sorted identifiers by the same order for multiple instances
- added some explanation re WiFi
- added definition for PMU on the WCN6855
- added some explanation for pcie2 max-link-speed
- Link to v2: https://lore.kernel.org/r/20240920-jg-blackrock-for-upstream-v2-0-9bf2f1b2191c@oldschoolsolutions.biz

Changes in v2:
- removed whitespaces and breaks
- added compatibility binding
- added feature list
- reformatted Signed-off list
- Link to v1: https://lore.kernel.org/r/5f5487e1-e458-4a3a-af02-c52e50ca1964@oldschoolsolutions.biz

---
Jens Glathe (3):
      dt-bindings: arm: qcom: Add Microsoft Windows Dev Kit 2023
      firmware: qcom: scm: Allow QSEECOM for Windows Dev Kit 2023
      arm64: dts: qcom: sc8280xp-blackrock: dt definition for WDK2023

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 1325 ++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 4 files changed, 1328 insertions(+)
---
base-commit: 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
change-id: 20240920-jg-blackrock-for-upstream-7c7aca20e832

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>



