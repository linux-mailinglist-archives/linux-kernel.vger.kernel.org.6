Return-Path: <linux-kernel+bounces-193340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD88D2A84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7269928772C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A5167DB9;
	Wed, 29 May 2024 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGAsfje+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DA167DA0;
	Wed, 29 May 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948151; cv=none; b=MFEjM6zDb5fOA7cD11Av7zObzqLX5AW2Pz3cpXHSBrd5/sHSRCr9GhdCZXE5+GCxlaYtF0pkXQWmUMLy2X5I7BzBEGPYPvhuxzMbwGAaDwKfQkncUjHBjkT4k8vgW4PoAqEO19sO75/XTd1yAxCnQOYo7kj3kHHJ5aetlsZyHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948151; c=relaxed/simple;
	bh=m8RVivrf6E1pKWyeR3UJd2My77826M9SSOcksm9icVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS3Mhz35XvjpskW2lXtTfrklSmyMFeTdgzw+V3fvVP1peF8TrB8sh9/baz26lki6TgUAx5stmaOKjWHorijLLULULiVNM4QEIkZ/s3QyeK3JzGrog+7gNm7++K9MV2NoxTfPUA9f7qrcWHoWEf/UhMGVWPKmCtc2QtijiaUX0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGAsfje+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B7FC32789;
	Wed, 29 May 2024 02:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716948151;
	bh=m8RVivrf6E1pKWyeR3UJd2My77826M9SSOcksm9icVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGAsfje+vAkOofcHbtYXB1412ZRakfkEsCay9lE0A6iZnNrhj9OY+GoPCJjRzcY85
	 a57Go9IZze2h0T1icMnxLdFKM2U4yzqoeYuFS+QG7uMmfIzsyPoq2EpyO5/+pMds2H
	 I68esbUkP6U5NQsXQ3/5Dviee2oJLe2TYaFNky441v5YcNvIFU8DdfSmbmYCLHP7w0
	 rVS0CJcYjiFogAj/qIPUMtSEQUefvy12PhHTCMOcnMuqIctqtci3bHJyY+jnKBYPbm
	 2HRDFxWFlfKKcTIk0su4CDwD1n/Okx9X2mhf/7DJ09OliHgWYA8tcRnwOgyZ7ujs6X
	 PBKz9+/CVHTZg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/2] Samsung Galaxy Z Fold5 initial support
Date: Tue, 28 May 2024 21:02:04 -0500
Message-ID: <171694812092.574781.2178262972154423898.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
References: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Apr 2024 18:51:29 +0200, Alexandru Marc Serdeliuc wrote:
> This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> ChangeLog
> 
> - v6
>   . Moved Acked-by to the right  place
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
      commit: d328da7f07563c1a4a21eae4b28b7b69d9ba3df9
[2/2] arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5
      commit: ba2c082a401ff6ea0f3460cd80174b4c8273445d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

