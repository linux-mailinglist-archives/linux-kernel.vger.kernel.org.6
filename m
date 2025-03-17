Return-Path: <linux-kernel+bounces-563276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91CA63C37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FB2188F519
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D017A317;
	Mon, 17 Mar 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjxCmjvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386E17A2F8;
	Mon, 17 Mar 2025 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180169; cv=none; b=MzQw2Bp4Bxu7OJR3/YmwnRVBCITopm+Bsl+7SiwY2t9MeDxNg1UEuy6I2HavAaoCdy3qs824WlGI0BN++P7/aHpivv2U/Wt5/j9Ihjg/YfmDCHhtQl2QYIWAa+A+oL1f2pMv2CebItfjojXViKmTD1P3VBkpEOEHVESlZ6s6OqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180169; c=relaxed/simple;
	bh=Kq5Yk1O5hdux3yK0P6/GqBt0RJp7aFW5IoYxa02drU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR5x9gAiOhjYhdylD3UnwkoNfW2Z5sdJY5hrekaEkQL2H0aocRTpiBhL+DoNhyzsINt8hrfX6B69+LnxLUIlYhpASCyIC4wzR1JYEtm+7wqahk+5hu4X2X/wTWIQ9ZxUNAsdEJBx8lzZYOfYEIZKtAJIq4RSZV+Ws8JwvnyIeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjxCmjvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112BAC4CEDD;
	Mon, 17 Mar 2025 02:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742180168;
	bh=Kq5Yk1O5hdux3yK0P6/GqBt0RJp7aFW5IoYxa02drU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjxCmjvsV03HK2cPkimdXn/yJD0xAWjeUqc3jRT/C+gsn3vFjuMwU+NuG0HfpEv0n
	 pALLbZw6kamtskeuj4QKmrkF3VPyPiO2YmRZt4AL4SFU2G0AwTJ0fCufBTWDu+F+OH
	 uw+2Ff8aRmgPC65+JDmJNuS8G1b0hPyQm6Qm9+AjnHKnDesvrCBeKWzJ2Z2Nlpsdj1
	 qQuZH/1Qp0FzO/Dq0PoJmliIvODb/6Pbj1BCYSwmza5z05Ru5whskyZKae4hE0z+8z
	 qVLw9Fg2WgauEx8oBzDD7ZhfsBR54vwOKsZyNzfGoIwZf+/bUUdmI/MAbOc5eGNeyM
	 L5XpN645YgFBg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: dts: qcom: x1e: mark l12b and l15b always-on
Date: Sun, 16 Mar 2025 21:55:48 -0500
Message-ID: <174218015888.1913428.7546953458616209863.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227081357.25971-1-johan+linaro@kernel.org>
References: <20250227081357.25971-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Feb 2025 09:13:49 +0100, Johan Hovold wrote:
> The l12b and l15b supplies are used by components that are not (fully)
> described (and some never will be) and must never be disabled.
> 
> Mark the regulators as always-on to prevent them from being disabled,
> for example, when consumers probe defer or suspend.
> 
> Note that there are likely votes from other processors for these rpmh
> regulators (at least for l15b) but the OS should not rely on that in any
> case.
> 
> [...]

Applied, thanks!

[1/8] arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on
      commit: abf89bc4bb09c16a53d693b09ea85225cf57ff39
[2/8] arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on
      commit: 673fa129e558c5f1196adb27d97ac90ddfe4f19c
[3/8] arm64: dts: qcom: x1e001de-devkit: mark l12b and l15b always-on
      commit: 7d328cc134f7db1e062f616a30cffe96fbc43abb
[4/8] arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on
      commit: 63169c07d74031c5e10a9f91229dabade880cf0f
[5/8] arm64: dts: qcom: x1e80100-hp-x14: mark l12b and l15b always-on
      commit: 3ab4e212a41c46668adf93c8d10d0d3d6de8f0e4
[6/8] arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on
      commit: f43a71dc6d8d8378af587675eec77c06e0298c79
[7/8] arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
      commit: ff6ba96378367133b66587bd3ee9f068a39ff3a9
[8/8] arm64: dts: qcom: x1e78100-t14s: fix missing HID supplies
      commit: 55e52d055393f11ba0193975d3db87af36f4b273

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

