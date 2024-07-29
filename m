Return-Path: <linux-kernel+bounces-265085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043793EC57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4011F2477F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D979142E9F;
	Mon, 29 Jul 2024 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCc9K3NE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77A1422C5;
	Mon, 29 Jul 2024 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225542; cv=none; b=lNPDSbyrgIkJMRTGYh1Pw3681rXpr03urY2dOvg1HETpPtiprw4zbCjHRCsuI9m3AFcU2saX27PzPOrNPdKUvDl/Pw3VmiPtTczhIHOjH1V5es8zzihjocOEjxrKFeks3Ecv0B3ci1n8nQrL54uSgR+WajI+3aumsSlQhYoum88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225542; c=relaxed/simple;
	bh=dSrPOgUsIyjtjeJHQWCuoWo1xW0ghb5lu9T5CfWdiUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F14mYCKwf6paWw1xxp0dO51+46BDrr1xVfpd/Yh9c4UxEaYi4qQD/Syu1KjKjoPsW21sAGTJ6wfKALfR+XTZmhJRCZLtz3qs8bghPTw50OvW+XFUdZijSxiXsz75+6v63/MgLccGaBnvMgTvhILmk1kh7k/OwS4jNTrX8OTua8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCc9K3NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51557C4AF10;
	Mon, 29 Jul 2024 03:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722225542;
	bh=dSrPOgUsIyjtjeJHQWCuoWo1xW0ghb5lu9T5CfWdiUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCc9K3NEA+loMC6zoy9B2ANaD1drrVbgNdx6IofJKzeENk1ZrFxF+Hz+a1d7D30I0
	 pkNCsPgzC1dbXpZl01FP3keDu4sls/k3fDOJyPfJpI5GbKhmCHxP5VzBQINMq7ILzp
	 4zVbZBjzfpotzThAieuhTGIFJWkCJmmSRaC7weIlztiJnSAma/s+7WyiySAbPVGK1W
	 niw845j9q9/pE7/Tux0COrK46qLZDiSWKWeAjRGi2RoGqK78gmTmvbVEYUaMTNmm1F
	 cHZGtDgAIwCf3FeiTfBlv/yrBWg7pOgdwZDvvZgN6HetdIa7Z2t2wm1tDPeO6bjAij
	 43rD2cNuOdrNg==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-kernel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Nikita Travkin <nikita@trvn.ru>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-rossa: Add touchscreen
Date: Sun, 28 Jul 2024 22:58:27 -0500
Message-ID: <172222551326.175430.16332190112821856592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131441.1764-1-raymondhackley@protonmail.com>
References: <20240723131441.1764-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jul 2024 13:15:09 +0000, Raymond Hackley wrote:
> Core Prime uses an Imagis IST3038 touchscreen that is connected to
> blsp_i2c5. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-rossa: Add touchscreen
      commit: 2bb08c4c9adcff11855b4a8d5e2f583306da883b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

