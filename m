Return-Path: <linux-kernel+bounces-549494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43337A55339
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E223A8EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6E25BAC4;
	Thu,  6 Mar 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="G9nMYHJi"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF118DB2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282876; cv=none; b=fRYk0vWBF1gLE23frZDvlkIMl6hnK8a1ZoRC1qKj1v97ZAG+7WT7qb2CKd5UNDmsQ4Ej/Y0Z7mB6GK1pL56lOK88MDduO8MqeFOUWPHGbm5WcYZaAMepoiKElP4EddOhO+4tq76FPoMSxahC10yOqLNSpezsqd3+JlJn+j+jm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282876; c=relaxed/simple;
	bh=LjmszaRAEJJwm2H2AZ593hmPt69gwPGDm2tLSxN1Kzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieb3IlkSyJL2nToAQBy5iga5UDJTqheUYxqTikwju4E/Zoz98zGUJ03gABy785aDg7ZqO2f8IgAtPBqOfOoWNc5qfCwM6HDg1M8jyX2lzaxBfsymX0tO6Rwvh1BNTv0+WTV4tEyEWm4WRZyqg6iddIX+6FcKM1+GoEayxPubJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=G9nMYHJi; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECEC04433B;
	Thu,  6 Mar 2025 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741282872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkJ/VEjjCBxppQWaYw13lM/kPl6RyNtHZYlEXGlS7A=;
	b=G9nMYHJiByhe8y/FnaXsEtDl/uX5qG4Ect3bqXzRHTGIMFcxJkFh0tYVbXfozDO/Nk9zZU
	qy/pQdM6TMHecYVYlp6Rcf/Ndqz0emSeeZpHTEVt+csDLGs4HEbD0TseTYjhvZmgk6wB2O
	uGxbp3rV7EGMjRUkHhPkEOJ/0RpGHmRgOHjH/U9xF3cSHPe0MdE52voQaP6/wcH8Wf9Fkn
	v0xmFoVPQr5AmF6a7s1UNQWt0e5jj3jTtjdQ0BCb4OyZZjK8AKmj1kbXjpgKn+s5hNCeTi
	ByLl+9vFcp8KKDkbMzOfGloVMlUMuQC8jee/9D04yJ7E5Vvf5t2Lde3QwzKREw==
Message-ID: <a968b291-63ed-4913-821d-16408c528876@yoseli.org>
Date: Thu, 6 Mar 2025 18:41:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20250302230532.245884-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20250302230532.245884-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeefieetgeehvdeggffgffetheehhfetkeefhefhgeeuheetueffueeikefgffffteenucfkphepledurdduieehrdduieehrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledurdduieehrdduieehrdduleejpdhhvghloheplgduledvrdduieekrddurdeingdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepgedprhgtphhtthhopehthhhorhhsthgvnhdrsghluhhmsehlihhnuhigrdguvghvpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrn
 hgvlhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Thorsten,

Thanks for the patch !

On 03/03/2025 00:05, Thorsten Blum wrote:
> The size parameter of strscpy() is optional and specifying the size of
> the destination buffer is unnecessary. Remove it to simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Tested-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

> ---
>   arch/m68k/kernel/setup_mm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 48ce67947678..0fba32552836 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -147,8 +147,7 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
>   			break;
>   
>   		case BI_COMMAND_LINE:
> -			strscpy(m68k_command_line, data,
> -				sizeof(m68k_command_line));
> +			strscpy(m68k_command_line, data);
>   			break;
>   
>   		case BI_RNG_SEED: {


