Return-Path: <linux-kernel+bounces-282822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF8694E902
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D26281C37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03616C84D;
	Mon, 12 Aug 2024 08:55:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D216C84C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452933; cv=none; b=Bjk6JY77Ye/BU9XH8ppVNYrV+BJgii03e3eBR1cujuGB7uxXU9L3MZsalQwbrb8uFIUUP+B9z2LtH1HsUPpLXjAOJT8WwbINCEgA+4c0LZbCs3Rt+Ka4xTp3R/cBy2TbinUu7fWdHrPXoPQmmYfm7wQov/vk/GFFqdkO8lHw2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452933; c=relaxed/simple;
	bh=kgvDoZldC8A2lDTTaRB9c/1Frjxt8QtjkW/XS07NIik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPcK8CCrS46RLoxHkkd3ccKzaW6IBlmQfwxc7bhyvbV99BmRM0TO97BGOr8kZ6zKEYGxqZny8p02wS0NMdUSA3ycBUzzed1wI3qqOvB4iHm+iyvj0GqZ6yCbMzfrYnjjRKp7Ye1TD/xKwVZJ5UY37YQgqbup2ZUqcSe2myyF5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1sdQpg-00012I-VG; Mon, 12 Aug 2024 10:55:17 +0200
Message-ID: <11fcfb45-3356-4460-a80d-6d110dd4bfb2@pengutronix.de>
Date: Mon, 12 Aug 2024 10:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240809082146.3496481-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240809082146.3496481-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 09.08.24 10:21, Oleksij Rempel wrote:
> Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> subnode name. The incorrect name caused the configuration to be
> applied to the wrong subnode, resulting in QSPI not working properly.
> 
> To avoid this kind of regression, all references to pin configuration
> nodes are now referenced directly using the format &{label/subnode}.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> +&{sdmmc1_b4_pins_a/pins2} {
> +	/delete-property/ bias-disable;

Nit: a heads-up in the commit message would've been appropriate.
Same goes for driver-push-pull, which disappeared, because it was
redundant.

> +	bias-pull-up;
>  };


Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

