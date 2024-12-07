Return-Path: <linux-kernel+bounces-436185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF689E823C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694E8165E06
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D296155A4E;
	Sat,  7 Dec 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uL3b1FZB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C63140E2E;
	Sat,  7 Dec 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733606819; cv=none; b=D+6gax/MZgUBn8g4Fp422mvApoStfduYdP/+ykKhppaSiFGUZSq7/42Az9XxkTwIwknXE4lFNz8BkBPRx3jqOLmhKZ/2OUv0lhT17le5ltDJfGPns58Isjt/aSZhHoZ5Rdh/YHnz62bbGmrOUmAaqa2KKYR5Hz+4KVQdlQ7Q/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733606819; c=relaxed/simple;
	bh=BkTU6JwU8h/ZZhUtvDaV4zZpcxcl7uN2qj34MO/H3F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBJGCkU9a3av/wpz6st8U888+0ZQyRIjaHPwj0ssGo9ErVMB4gZy4TxNHpZTdbbR10SfePdWwy4ae3oWB6vSzxubX4c4EcSfIuZW3k1YDsTNQpKp59f3SW3LrUujcEeeODWfv6TptfzkjQ47FLtGSA2Qrpp9PwbOfZ5lIuOKz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uL3b1FZB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733606794; x=1734211594; i=w_armin@gmx.de;
	bh=lbxwWAIzvB3xXlSH6gAQr2bOhtsrtgXqv3pNOIaaw7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uL3b1FZBJtA9xQCC2QwL8PPO1anlg5g+mAmcXkVYJsMKDuJ6spXXWWK6mP98o7NF
	 qTU5BgBe2UejacDG0dqj8UlZ7qSZmKisKsbMSoR2iEH+biLg6z08DsoyRh7k9YdA1
	 ZcQ9RTooKkzknXryXJeUn9+CdvGpfbVbsWfocyW5ghuUla7M4tKXxL2pxWP6vjtLc
	 lYoP90rUJV9fnrj5iHQtCICfSuNc6pjlWVGXas9I8H24p/QMFQ9cqWc/CJyGknDH7
	 Tb4udI2Tf7Y8Bt6mmionfZDSuR4bDGXqrZnEsgNubMQaZnxQvEkVbfqeuIdvS1Ccq
	 8ytvhTSw99ETqYimgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1szB1K1g32-00X5Fq; Sat, 07
 Dec 2024 22:26:34 +0100
Message-ID: <fa78f27a-a92c-452d-b710-c4b3c8c52629@gmx.de>
Date: Sat, 7 Dec 2024 22:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell XPS 9370 to fan control
 whitelist
To: Povilas Kanapickas <povilas@radix.lt>, pali@kernel.org
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e5d65c8a-4785-4635-ad77-d5155f517155@radix.lt>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e5d65c8a-4785-4635-ad77-d5155f517155@radix.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:z70uc1uHaZvNgS7lDcq1+/aMOpyT6N6jsTBA4WrGdaGvJvbTlxx
 bwtQdtZqH+7KAYj9ZEVe1/vkLnRlHO22S5Vay5XHQzbLg+N+3rI4swrJYoZrDhrQdj8LAyl
 72hNBoFKxva8MLDQCIXLjp8VJEJCMrkhTyonAvZeciaq5k5hEMUuCNVXkpntD93XoAJZs7y
 O5yjTCr6RtSMYjk41WpSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kgwqr7U45aI=;RZeVQfepZleAdZTnniCXBFRziux
 z/I+yO8GbQof4M9bSG57AGNQnt7cn0pdyfBr6wy5HXAYSMbtnSz0qcDCy7nbmA1TNuqMpMq9c
 1qQV3DRCmk8hDlWuvOTiOR/f+tx0ENKBxqadAUBpN58zFzBMn1chNqIaRRD4R0FuN+0ijc49k
 rwP9JQvXEdoFxA0fJL/BT9k5l5OliypFhBB3w/tkYEX7//rAWbwxSakydBp1b51hNs10kPucU
 UP3AarvkhKot9l82TZoAkLm8ys8Rqu0u8cpvzu4/PFkUGn8sswjZW3o3d9x/1ZJqmj7OLMlLH
 UJLR+idiDk/5I66Xprx6laCTWr1eOR2uZ4Cd5uJ0gdgcz6cziQGyyrIpvJBwJAfiWCMyiT9Jg
 Za3KQcVX1eV7CbVADsa9nPEMLAjKwUM18UkkRqg5vCAdmF3LBAxR8evqmarpHuIQq/+gKdLIB
 R4EdEDJHpuBNDpmvDoFTAylWbq+8/AydNlJyirEWPey8wBM4GAb2p3osqmnt9TOF7QkZQZ17N
 5fN999JOuo1PST60HhwFI0jp6VkY4tYfgIA7xfFSb5rIBmfeXxOAaPJIeyusVMDqfj5yXgpKX
 8riLJIqyyOLHYRbLwxCnO6YjsiaYOihfW4ii/vY4bdL6fsJsJHt0z7acIcxlnbSIEDVW7zZ2b
 UrnwEza6+5w004tkZIz/cHYGPVWYPl0xuEcLokAgxYDSG02vkJsILD6TG50FYMlAStL1kRB1J
 eBieSo35gcc3WyaNo2Z7Sxh4qxVnirqHWz4jV5uXcWcZBy793FEesSwttS8rj/u19uiDfQDli
 fxOXCiC74QvldfUcGV4ajgSfAa2hFSnuJteZIcyi6UFbtSPbZfsMhAbwejos2UibHxveBUvbw
 FT36BFL82vKW61BFgG3Y0TsmZcOxjMmF1+TEDxtrPyuKk9aOuddo28fSmlGS4rrdMc7XOtu3b
 2OrC0dJ+4vhNzryiRUeSoXqhDQYLxkhnknLDFpXJZO20JA50LTnbr9AK99HmhFZnR8vZIjN2V
 EY+gMcYSxZturTRTNZQgfcE4qyXHY1nedlWMtWBikbkpC0Q5bFaO7t+MxuvAUu30FrAwu+/U2
 gEB3nOGDlDk6PIjZ7yk94dj30qxhKC

Am 07.12.24 um 21:26 schrieb Povilas Kanapickas:

> Add the Dell XPS 9370 to the fan control whitelist to allow
> for manual fan control.

Can you check if using i8k_fan_control_data[I8K_FAN_30A3_31A3] also works?

The reason for this is that the official Dell software seems to use those SMM calls
to enable/disable automatic fan control. If this does not work then you can keep
the i8k_fan_control_data[I8K_FAN_34A3_35A3].

Thanks,
Armin Wolf

> Signed-off-by: Povilas Kanapickas <povilas@radix.lt>
> ---
>   drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f5bdf842040e..bcb295ea3319 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1544,6 +1544,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>                  },
>                  .driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>          },
> +       {
> +               .ident = "Dell XPS 13 9370",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 9370"),
> +               },
> +               .driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +       },
>          {
>                  .ident = "Dell Optiplex 7000",
>                  .matches = {

