Return-Path: <linux-kernel+bounces-411126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EE9CF453
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1F6B3E5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CD1D8A0A;
	Fri, 15 Nov 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP2vswY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75D12B17C;
	Fri, 15 Nov 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693388; cv=none; b=AzA+6BDpFYj3GwL9uPYKVUOyk5H4lms6+Cgx57UbpoGirzynORiXD+w2bNqpdeZ884bcg9E8Oj3iNYxCVKuztYmi/S3EKswGpOYW190m8Xi1RNLjC4E8jy+9zr27lV2Xb9M7PQwnGlnizYZO0OGbffF8qwGnsK+u0ini6e/XoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693388; c=relaxed/simple;
	bh=PpjHatN5WUoKRqKa0DE4zFuPaulc3V56sLVbfXpGETk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+KekTb1V4i7ZeDgdIlzq3K9yuTi0Kke92YsHA6iFkcVn7E/DF65FjaxWZ5EKulyd86BGo/Uy/qhy4l4x6b1bt0GBA08VoRoHYihs/9H3Feq/RUveJU652n7uYC+HmIVReBSfWxKg15gB4hMuxmg5i5hBjIPQa2zR5Ht0qL6jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP2vswY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3BBC4CECF;
	Fri, 15 Nov 2024 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731693388;
	bh=PpjHatN5WUoKRqKa0DE4zFuPaulc3V56sLVbfXpGETk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HP2vswY0Fjhtfvm6xM/UAqEvSORiNQ/P1DUYFNrbDv3s4+rLoy6RS77Y44bdm/4Pe
	 GEDjj9oGiSmoAvXjYRPRB0nbFVHqYKvW6aKzwEb6uH4Anvgcw1Ln1a1w0YWBtUiL2u
	 am4oCjD2My1deqe1wkCsP1TJw2703Q3suxVCyr9UqTF6Vo3fyW7/UQtV+xiZsAQV0g
	 X6R0rTrAA731e41VIL8X66HjnNWY/LrXEN8OTutmngoqjmRJ7NRGDADcp5ejoy7cfw
	 NRM/4D16WxQ2OExK7jKCnKj/oDVqZFfOlrSwYYOSi+xxHuROEINQ+K933TwXniojhW
	 9jO7RkJZq7PIw==
Date: Fri, 15 Nov 2024 11:56:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: devicetree@vger.kernel.org, bhelgaas@google.com, kishon@kernel.org,
	quic_tingweiz@quicinc.com, quic_tdas@quicinc.com,
	conor+dt@kernel.org, quic_aiquny@quicinc.com, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	andersson@kernel.org, quic_qianyu@quicinc.com,
	quic_kaushalk@quicinc.com, lpieralisi@kernel.org,
	neil.armstrong@linaro.org, manivannan.sadhasivam@linaro.org,
	robh+dt@kernel.org, konradybcio@kernel.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
	quic_shashim@quicinc.com
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the QCS8300 QMP PCIe PHY Gen4 x2
Message-ID: <173169338569.3465197.14104192908235199622.robh@kernel.org>
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114095409.2682558-2-quic_ziyuzhan@quicinc.com>


On Thu, 14 Nov 2024 17:54:05 +0800, Ziyue Zhang wrote:
> Document the QMP PCIe PHY on the QCS8300 platform.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


