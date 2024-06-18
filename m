Return-Path: <linux-kernel+bounces-220204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023B90DE08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1908B281C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972E176FDB;
	Tue, 18 Jun 2024 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9yLqdUn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568E13C807;
	Tue, 18 Jun 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745200; cv=none; b=fEJfvBhthKZey23utT5xBBBcLuKfCFpHxWychqe6Gp4kc4YqFC/iAvDzW0ojTOA45HnZswhKr4IzsMdx0g1llao9dyNG8Qv580nNgXRLLEIS3gc+9pODYAJ5FjbiZM2DMTItIJBseUdJOX8UDS4VxmHYmIC78Sct6juFmaxVX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745200; c=relaxed/simple;
	bh=NcfVhT9gMMjZGoIOY4DM9U3BF+gwE7JfSDFLuuTj274=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOsg8Y2vh3USU8F9mCe3n+YIc/dak7QKO7PNTA1oeW8eRv5hpPbxmTRkN7yvgQE18K5DduNyBIoJPK+cmGctbkBGUTn5hb/87izDrHuBmCmAKGurM0+41J5Bw4FVwyKoQH4QG0vaeJq1lqMy2J0ddY6l07YOFxW1Dx9kJ+Gsjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9yLqdUn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=frly9dC4Mep9TThjtzq3x+ws1mwR1jwn8ldlHwBQIxw=; b=Y9yLqdUnSRRb2YuGuPuWLVpo/v
	1G+wfoGL8r4PDVGLyXkEJOIcbxNgYei0zkxgETM/2zgN9B9evAJv66K+U/H6TmOubKBKepfJzfoJp
	9IsCEDBDI9yM8hSLUDLR3/BtPojXUw0r+ayBr5j1dik8PwgZrQHro+/HYQ/mPgUaC8T+fbuzyxm9m
	D3xatsOEidfawoLbhVXqH9084ngy0Rqi+HM/ziG7KtLmc0qZXu/qq/TyYFSLEklPte8JeEkEz1sP2
	pI0RF2NxYigvf53XSpM4WGFXYixWDRiHVBEdRIoCV+C4jYbEd2uDGYN1jOSPa0Fi8i1PQSRr9F277
	DrhkFV9Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJg8g-0000000GcSV-2dt4;
	Tue, 18 Jun 2024 21:13:14 +0000
Message-ID: <c786ad0d-2a25-4066-b0df-04decc037c16@infradead.org>
Date: Tue, 18 Jun 2024 14:13:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] Documentation/firmware: add imx/se to
 other_interfaces
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-1-a7d28dea5c4a@nxp.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240617-imx-se-if-v3-1-a7d28dea5c4a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

IMO there is an overuse of hyphens (dashes) here.
Please consider the changes below.


On 6/17/24 12:29 AM, Pankaj Gupta wrote:
> Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
> that contains the NXP hardware IP(s) for secure-enclaves(se) like:

Is the product referred to as "secure-enclaves"?  If not, "secure enclaves"
should be sufficient.

Hm, https://www.nxp.com/products/nxp-product-information/nxp-product-programs/edgelock-secure-enclave:EDGELOCK-SECURE-ENCLAVE
just says "Secure Enclave".



> - NXP EdgeLock Enclave on i.MX93 & i.MX8ULP
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../driver-api/firmware/other_interfaces.rst       | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
> index 06ac89adaafb..65e69396e22a 100644
> --- a/Documentation/driver-api/firmware/other_interfaces.rst
> +++ b/Documentation/driver-api/firmware/other_interfaces.rst
> @@ -49,3 +49,122 @@ of the requests on to a secure monitor (EL3).
>  
>  .. kernel-doc:: drivers/firmware/stratix10-svc.c
>     :export:
> +
> +NXP Secure Enclave Firmware Interface
> +=====================================
> +
> +Introduction
> +------------
> +The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creates an embedded secure

                             Edgelock Enclave

> +enclave within the SoC boundary to enable features like
> + - Hardware Security Module (HSM)
> + - Security Hardware Extension (SHE)
> + - Vehicular to Anything (V2X)
> +
> +Each of the above feature, is enabled through dedicated NXP H/W IP on the SoC.

                     features is enabled

> +On a single SoC, multiple hardware IP (or can say more than one secure enclave)

                                         (or more than one secure enclave)

> +can exists.

   can exist.

> +
> +NXP SoCs enabled with the such secure enclaves(SEs) IPs are:

                    with such

> +i.MX93, i.MX8ULP
> +
> +To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated

hm, "co-existing" is a (UK) alternative for "coexisting" and since we accept
British spellings, it is OK.

> +messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive

                                  why not       'SE'
?

> +MU(s), dedicated to itself. None of the MU is shared between two SEs.

                                           MUs
or
                                           MU(s)

> +Communication of the MU is realized using the Linux mailbox driver.
> +
> +NXP Secure Enclave(SE) Interface
> +--------------------------------
> +All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be

                                                               no comma    ^

> +enumerated and provisioned under the very single 'SE' node.
> +
> +Each 'se-if', comprise of twp layers:

      no comma ^             two

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

                                                           no comma   ^

> +  for communication with firmware.
> +
> +  FW Communication protocol ensures two things:
> +  - Serializing the messages to be sent over an MU.
> +
> +  - FW can handle one command-message at a time.

                         command message

> +
> +- c_dev:
> +  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
> +  Using these multiple device contexts, that are getting multiplexed over a single MU,

                            no comma     ^ that are multiplexed over


> +  user-space application(s) can call fops like write/read to send the command-message,

                                                                         command message,

I prefer 'userspace' or 'user space' over 'user-space'.  'user-space' is the 3rd most used
of the 3 spellings in the kernel source tree.

> +  and read back the command-response-message to/from Firmware.

                       command response message

> +  fops like read & write uses the above defined service layer API(s) to communicate with

                            use

> +  Firmware.
> +
> +  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
> +
> +                                Non-Secure               +   Secure
> +                                                         |
> +                                                         |
> +                  +---------+      +-------------+       |
> +                  | se_fw.c +<---->+imx-mailbox.c|       |
> +                  |         |      |  mailbox.c  +<-->+------+    +------+
> +                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
> +                      |                               +------+    +------+
> +                      +----------------+                 |
> +                      |                |                 |
> +                      v                v                 |
> +                  logical           logical              |
> +                  receiver          waiter               |
> +                     +                 +                 |
> +                     |                 |                 |
> +                     |                 |                 |
> +                     |            +----+------+          |
> +                     |            |           |          |
> +                     |            |           |          |
> +              device_ctx     device_ctx     device_ctx   |
> +                                                         |
> +                User 0        User 1       User Y        |
> +                +------+      +------+     +------+      |
> +                |misc.c|      |misc.c|     |misc.c|      |
> + kernel space   +------+      +------+     +------+      |
> +                                                         |
> + +------------------------------------------------------ |
> +                    |             |           |          |
> + userspace     /dev/ele_muXch0    |           |          |
> +                          /dev/ele_muXch1     |          |
> +                                        /dev/ele_muXchY  |
> +                                                         |
> +
> +When a user sends a command to the firmware, it registers its device_ctx
> +as waiter of a response from firmware.
> +
> +Enclave's Firmware owns the storage management, over linux filesystem.

                                                        Linux

> +For this c_dev provisions a dedicated slave device called "receiver".
> +
> +.. kernel-doc:: drivers/firmware/imx/se_fw.c
> +   :export:
> 

-- 
~Randy

