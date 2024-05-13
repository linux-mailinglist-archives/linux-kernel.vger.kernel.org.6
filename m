Return-Path: <linux-kernel+bounces-177259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899628C3C13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CAC1C21139
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF4146D53;
	Mon, 13 May 2024 07:30:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848F146A83
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585428; cv=none; b=CGa6AjnDz1lF/WB3EE7gxYwx08CPPyRPQiy0jGjJg12sP+kNqSuvCSaPjQM+hUDS4Nc4651MA0V0wMKaGtWNOmOuLeN8J49dcO/V9MPMcIXXi68RM3RBAyAhjyT4NxqFZTMmrtLhYc5odEtnckXxdfArLLZQ4VJh6VvWb1IezcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585428; c=relaxed/simple;
	bh=7zuS+Z7tyMM3sKndT2tFxoEE1VWsyl5MBkd5oEoxV9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFbq2NhF7jzyrm+KxVCGFAuaG0dXikR1efyt520Em5zs0KXaLCafBa+rZOraMk6F8MZDYKobLRM7dd4HSyEyxwStI7nmhyrQTb/3F5indYRNHbHifwRDeVzIahzIsbYsRk5uNauM4WSv6+5qLcm2g6aazLUpvfMUkqewIGNsa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Q8R-0003zN-Po; Mon, 13 May 2024 09:30:11 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Q8O-0017tV-1W; Mon, 13 May 2024 09:30:08 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Q8N-009P4h-33;
	Mon, 13 May 2024 09:30:07 +0200
Date: Mon, 13 May 2024 09:30:07 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] Documentation/firmware: add imx/se to
 other_interfaces
Message-ID: <ZkHBf9o522w0E2jR@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-1-27c5a674916d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-se-if-v1-1-27c5a674916d@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, May 10, 2024 at 06:57:27PM +0530, Pankaj Gupta wrote:
> Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
> that contains the NXP hardware IP(s) for secure-enclaves(se) like:
> - NXP EdgeLock Enclave on i.MX93 & i.MX8ULP
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../driver-api/firmware/other_interfaces.rst       | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
> index 06ac89adaafb..c18c2d3e6e08 100644
> --- a/Documentation/driver-api/firmware/other_interfaces.rst
> +++ b/Documentation/driver-api/firmware/other_interfaces.rst
> @@ -49,3 +49,129 @@ of the requests on to a secure monitor (EL3).
>  
>  .. kernel-doc:: drivers/firmware/stratix10-svc.c
>     :export:
> +
> +NXP Secure Enclave Firmware Interface
> +=====================================
> +
> +Introduction
> +------------
> +The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creats an embedded secure

s/creats/creates/

> +enclave within the SoC boundary to enable features like
> + - Hardware Security Module (HSM)
> + - Security Hardware Extension (SHE)
> + - Vehicular to Anything (V2X)
> +
> +Each of the above feature, is enabled through dedicated NXP H/W IP on the SoC.
> +On a single SoC, multiple hardware IP (or can say more than one secure enclave)
> +can exists.
> +
> +NXP SoC(s) enabled with the such secure enclave(se) IP(s) are:

There are already multiple NXP SoCs with a secure enclave, so you can
drop the braces around the plural 's'.

With (se) you refer to the acronym SE for secure enclave, right? If so,
please write it in uppercase letters.

> +i.MX93, i.MX8ULP
> +
> +To communicate with one or more co-existing 'se'(s) on SoC, there is/are dedicated
> +messaging units(MU) per 'se'. Each co-existing 'se' can have one or multiple exclusive
> +MU(s), dedicated to itself. None of the MU is shared between two se(s).

between to SEs (the plural 's' is not optional here)

> +Communication of the MU is realized using the Linux mailbox driver.
> +
> +NXP Secure Enclave(SE) Interface
> +--------------------------------
> +All those SE interface(s) 'se-if(s)' that is/are dedicated to a particular 'se', will be

interfaces (no 's' in braces).

Please use uppercase letters consistently for 'SE'

> +enumerated and provisioned under the very single 'se' node.
> +
> +Each 'se-if', comprise of twp layers:
> +- (C_DEV Layer) User-Space software-access interface.
> +- (Service Layer) OS-level software-access interface.
> +
> +   +--------------------------------------------+
> +   |            Character Device(C_DEV)         |
> +   |                                            |
> +   |   +---------+ +---------+     +---------+  |
> +   |   | misc #1 | | misc #2 | ... | misc #n |  |
> +   |   |  dev    | |  dev    |     | dev     |  |
> +   |   +---------+ +---------+     +---------+  |
> +   |        +-------------------------+         |
> +   |        | Misc. Dev Synchr. Logic |         |
> +   |        +-------------------------+         |
> +   |                                            |
> +   +--------------------------------------------+
> +
> +   +--------------------------------------------+
> +   |               Service Layer                |
> +   |                                            |
> +   |      +-----------------------------+       |
> +   |      | Message Serialization Logic |       |
> +   |      +-----------------------------+       |
> +   |          +---------------+                 |
> +   |          |  imx-mailbox  |                 |
> +   |          |   mailbox.c   |                 |
> +   |          +---------------+                 |
> +   |                                            |
> +   +--------------------------------------------+
> +
> +- service layer:
> +  This layer is responsible for ensuring the communication protocol, that is defined
> +  for communication with firmware.
> +
> +  FW Communication protocol ensures two things:
> +  - Serializing the multiple message(s) to be sent over an MU.

Just "Serializing the messages to be sent over an MU"

> +    A mutex locks instance "mu_lock" is instantiated per MU. It is taken to ensure
> +    one message is sent over MU at a time. The lock "mu_lock" is unlocked, post sending
> +    the message using the mbox api(s) exposed by mailbox kernel driver.
> +
> +  - FW can handle one command-message at a time.
> +    Second command-message must wait till first command message is completely processed.
> +    Hence, another mutex lock instance "mu_cmd_lock" is instantiated per MU. It is taken
> +    to ensure one command-message is sent at a time, towards FW. This lock is not unlocked,
> +    for the next command-message, till previous command message is processed completely.

I don't think such implementation details belong here. They are easily
changed in the code with the documentation update being forgotten. I'd
just leave the bullet points here and add the detailed description as
comments to the code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

