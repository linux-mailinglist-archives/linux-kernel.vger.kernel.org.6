Return-Path: <linux-kernel+bounces-203456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC078FDB80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB841C23417
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661398F7D;
	Thu,  6 Jun 2024 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQqU0uAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802179F5;
	Thu,  6 Jun 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634040; cv=none; b=LHqNx6A244ec31Uzbcmqxr/RNm8buDL/YLGvnjIVODUcoUJUaFtzpl6mcM/2zFwBZIIDb1OdnZY8qtK5TSexWt646Dp+X7+oBf+ufM3k3ctw5Eps19D7GySTegf6uAsFZ+u0n/1uuRbziBB0a6GZkUra2mvp6IppHKUGk+QmmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634040; c=relaxed/simple;
	bh=o/c2SY2SdtrHHxFtvOeQwKlUGe+wuEu5QP2QRQHLSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSe/RS89X+wjDGhB5BeEUVRWW+Ffb+sLOeEF1EJlKo/2nqHg3RY42oPMNq8GXGilA0fEckH6mvNiFepiIPsJUmb9hpha+YF0ha7nDRHjCi0y9m/MpYZ3T/BRxngCjlxOH7y0QVgfaLPhJJxf/M8E+0BgoUlC5FKRhun5/7TgVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQqU0uAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED856C2BD11;
	Thu,  6 Jun 2024 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634040;
	bh=o/c2SY2SdtrHHxFtvOeQwKlUGe+wuEu5QP2QRQHLSQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQqU0uAo6YZR9MB9nD7gIN7IZbLcLM3q95r2XSqF4caEgCZPWbmbjSvwAvxq2LPtw
	 IqhkA6WBcFHJM4kuDo7PncPgXxx08u7/1cig8Xgj4aUV+rT1xy3VJyEj/FmrHwjuc0
	 cAdRQtmpG9QgdJmGxTzLq0jRozQMcq6SK6yfoeJ5Ssy7MJS/kCa5X4izdq1Cs4bQ9F
	 y7K4woIiPkE/nszaljK/thYmXQp2V98P0QD5v18i9qQ+SF/JNcwuW4wESFupBG+bLW
	 xPpOv48yQlUTV0/GuzyB2SA3C5qUHh7K8j/GlflY/Vp1kYW/tUh7R7I6KV5HtwBrKt
	 2qXp8wLv/jqJA==
Date: Wed, 5 Jun 2024 18:33:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: g12a-usb2-phy: add optional
 power-domains
Message-ID: <171763403568.3519766.9448445516249166136.robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org>


On Wed, 05 Jun 2024 11:36:00 +0200, Neil Armstrong wrote:
> On newer SoCs, the USB2 PHY can require a power-domain to operate,
> add it as optional.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


