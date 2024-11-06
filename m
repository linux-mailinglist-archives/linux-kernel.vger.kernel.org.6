Return-Path: <linux-kernel+bounces-398437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E569BF14A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D3F1F2286D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73702022C1;
	Wed,  6 Nov 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CIhO9yWA"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E571D6DB4;
	Wed,  6 Nov 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905972; cv=none; b=aQ6KdPPx5uZy5vfgvmMIiDKotaF363ljBOiCvjDtuu1cIKozGCn1oeSV1oIYrCVBJqclcbCfEidPzN0YAc9Di/jM6/2JPIH+LHX0AaT+id5sc1EaAwGcf2Byb8BzqU2pJ87jwOUl3ZbAzlXZ4RPTanKzjV9yZ5YQaDNFe+8xjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905972; c=relaxed/simple;
	bh=ozryd/UtPtNOTF77hbNUwpOtycVK75LwJ66j/DW2x4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvyylo8akhPr5k7v+J0IV0rfH5Rm3z1SJGFvBg8c/J7XJmF+i0vuJ9OTGGFlFMb8IN9XGOApkbBrOXbcXv5c2dCYFZ8FTutxx1Z0n1M1GuPzemLrgIhL7HYBNftrOKvGCoP7Kb4mmg9Af3N4bQe7kK23ezE5JmbPVm5J24QZbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CIhO9yWA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18EAEFF80D;
	Wed,  6 Nov 2024 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730905968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5hkMYCqGlZpFOC6ewIYYqBz7g5jw0DRXZWzNXBRAr8=;
	b=CIhO9yWAhWDMpDu3VqyrvyTROhVJeTtEDGC7jyCggwttz2tKoVNfKffH+x/sAALnIewrdE
	e6dYRjjeBj+5oFm5XDBg4tdiCRHWDRmH2LzjEHwLAn8LJfvu3FH9vftYqFtvtFo6rmi3bV
	+WVL3Ov4z/n/Hibn2AhD4TZsZ1ZsmeTFMcFL6c0TkF/VJkKY2xkQV3DI1Byslq8MzwXzRY
	VLhcNDJNp3INZ8L3R80NTRoYP63BHNkYaniOURNzi9Z2w/rlzbaAw1iUpBeHf342qh8pyh
	/0lnVTZg3X1I75pcrbeodkwPsjBCazLP4k9q2X9XFxn1NG94OGpizljQ7rK00g==
Message-ID: <0c891f4d-3e59-40b6-9bca-5207d2cbaad1@bootlin.com>
Date: Wed, 6 Nov 2024 16:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: atmel_serial: Fix typo retreives to retrieves
To: Shivam Chaudhary <cvam0000@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, Hari.PrasathGE@microchip.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241106142720.41351-1-cvam0000@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20241106142720.41351-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

Le 06/11/2024 à 15:27, Shivam Chaudhary a écrit :
> Fix typo 'retreives' to 'retrieves' in atmel_serial.c file.
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> 
> v1->v2
>   - Improve subject line.
>   - Improve commit message.
> 
> v1: https://lore.kernel.org/all/20241024172300.968015-1-cvam0000@gmail.com/
> 
> 
>   drivers/tty/serial/atmel_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 09b246c9e389..bb1978db6939 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1166,7 +1166,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>   		port->icount.rx += count;
>   	}
>   
> -	/* USART retreives ownership of RX DMA buffer */
> +	/* USART retrieves ownership of RX DMA buffer */
>   	dma_sync_single_for_device(port->dev, atmel_port->rx_phys,
>   				   ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
>   
Acked-by: Richard Genoud <richard.genoud@bootlin.com>

Thanks!

