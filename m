Return-Path: <linux-kernel+bounces-562060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0822A61B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7300317DDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984720C02F;
	Fri, 14 Mar 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7dzfWVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39620B1FC;
	Fri, 14 Mar 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982500; cv=none; b=KaHaCiNZROSK2RzYvrPcnfwVi0Zsw4VY2MyGUpj2cBantU7pdYkoNSTWVv4HwDJJxDS70Wp6RuGRCJ0uC2/vI98zGjIK9PGVmjcGDgQeXw2DnUWd43lZ8ApxrYUK1VQOVSaLU343JjXPKPoo1RSHJONhYz1PgFTdu0W3pbZqiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982500; c=relaxed/simple;
	bh=zwch4t6j1zzF7yxX+PgcDgC1C92C8C71CIO7BC5G1g8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN7MG1Kjeethx89CHig73l617DasqJc02YQQKUr8eAUGIXWB2OEpqXO+tOrSsmtQAJyuwVvJTOR8uCopZldBUZms2a6AIul1qddiSzpUhjcVT4W4NcD7QG+KFFWuOfrSjey5O2EW+DELtA9JcipZKIYhEipQ24wEqtujtJLbjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7dzfWVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC4C4CEED;
	Fri, 14 Mar 2025 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741982500;
	bh=zwch4t6j1zzF7yxX+PgcDgC1C92C8C71CIO7BC5G1g8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=S7dzfWVWd2viHvlpMCm3FX6GXxBdWrQL1FpFU5+8MIuTfNKliVs6Jweb+2bsXBSVI
	 s3hY4n0jQeodEcB+BF7f9QQ0dBZVO4UbYJc7O2MiuMuWri5AJFm7jlBoaKnDRAYe89
	 ApJeQ1UHdrbo2C5D6Mxd+r11pervzKQsCbC9XQgGbtvIcpEdoCSE34AyKXmHuE1/0A
	 Wt3OX3Af/zQgsl5ecmRXAMco4dnQwrqa196bueZBjsfr0XdNdu9j/MPadYSQQyZiys
	 rmPfbLC7rcnOScobVRYg/TnNI6l+jdV64jOGkEt6LEm7c0f97HJ5j0BsI1JGcbgJiO
	 9T3Vm6+Xh0STA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: Use recommended MBN firmware format in DTS example
Date: Fri, 14 Mar 2025 15:00:54 -0500
Message-ID: <174198247863.1604753.14372785384634032942.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250108120530.156928-1-krzysztof.kozlowski@linaro.org>
References: <20250108120530.156928-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 08 Jan 2025 13:05:30 +0100, Krzysztof Kozlowski wrote:
> All Qualcomm firmwares uploaded to linux-firmware are in MBN format,
> instead of split MDT.  Firmware for boards here is not yet in
> linux-firmware, but if it gets accepted it will be MBN, not MDT.
> 
> Change might affect users of DTS which rely on manually placed firmware
> files, not coming from linux-firmware package.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Use recommended MBN firmware format in DTS example
      commit: dd5c8d7222fbccd7d0accb7523e11657b827cc99

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

