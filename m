Return-Path: <linux-kernel+bounces-560893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA17A60AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C2F460335
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52C8635C;
	Fri, 14 Mar 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxKlMpaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F381531C4;
	Fri, 14 Mar 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939296; cv=none; b=eurB7PBcJrvcYt3wakgtR6aEJJeekjt82Y0tn2X14rew4oKv8UtIa1Qq0xSCZIyZqrWBX6oJbUFq4s0krtvxZgINkKtRq6EU+z5WP72kCSL7ZdNjXXtwiwLPbcfmq8NKo0ZMXIKEDYZT6jb1wE9Wpw6b1BuwBpVw8ST6YCIoR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939296; c=relaxed/simple;
	bh=70wuHHsetHGL0OD/EkgwP5SjrI60aviLDRUiNp6RteI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGhNWF4umYUJ3KxPhAXyErje92Nh6VvykwTYXZiqQ9X1dUjGlbIMHEmsYxrk8IEehBk7xfsXwLptBkJVHTqLxocmgzYC5kBmhuur6Dlc+8kTFLcLy1TntwSaavR1TyphRp+V2HmEEndnIdnKKP294FBaEzDQl0KWDoyVBsAjpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxKlMpaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF472C4CEE3;
	Fri, 14 Mar 2025 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741939295;
	bh=70wuHHsetHGL0OD/EkgwP5SjrI60aviLDRUiNp6RteI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxKlMpaYsSSO8B8lDQwLdpB4UzGrdvlyZaNxFnwda2QCfDMT/4INPK/1RBo3AuILi
	 zeC5XMIn3MnQPZ9hSulmieLPcg06jW5EG8sjcLJh0j4ffqf/o9bSoTR6mYc5p4GwH9
	 PVL/8Nmnm1rThXv3QxLDu/DmTbj54dAaVkrSslfex/4P/+q3bkjDgXfte9LQQREz0Q
	 wHOsUBtRK9ibP5gIzfxDYyd3X6Q/h7cBxPBi72NEn5oQSxYEEaNo8idK6kJu3UrZKH
	 Ioxw5voPBI0qaCa3gzwq4bVcWHkHkmBCKZhx9xs1l0a2FAcuzONsQ6av0YDlzDMZ+a
	 m4L3h6YbwIZ3w==
Date: Fri, 14 Mar 2025 09:01:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zelong Dong <zelong.dong@amlogic.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: amlogic: Add A4 Reset Controller
Message-ID: <20250314-tested-husky-of-force-1ccdca@krzk-bin>
References: <20250313-a4-a5-reset-v4-0-8076f684d6cf@amlogic.com>
 <20250313-a4-a5-reset-v4-2-8076f684d6cf@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313-a4-a5-reset-v4-2-8076f684d6cf@amlogic.com>

On Thu, Mar 13, 2025 at 05:05:35PM +0800, Kelvin Zhang wrote:
>  &apb {
> +	reset: reset-controller@2000 {
> +		compatible = "amlogic,a4-reset",
> +			     "amlogic,meson-s4-reset";
> +		reg = <0x0 0x2000 0x0 0x98>;
> +		#reset-cells = <1>;
> +	};
> +

Why do you have on the bus devices with bus addressing and without it?
What sort of bus is it?

>  	periphs_pinctrl: pinctrl {
>  		compatible = "amlogic,pinctrl-a4";
>  		#address-cells = <2>;

Best regards,
Krzysztof


