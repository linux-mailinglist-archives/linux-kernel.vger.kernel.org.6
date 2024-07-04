Return-Path: <linux-kernel+bounces-241715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6DB927E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568AC1F23C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1113D275;
	Thu,  4 Jul 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="tnFgOhp7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB818AED;
	Thu,  4 Jul 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720125567; cv=none; b=KVP5Er4PtkEH4tCxZzUmcUotyaby6qtqhtepdP55iIwN1x59t92A/R+DQXZOxjdogSTmtOQRIAy8DVqdJCFMqlqQF71PMive7YCIvu7yNpwthKgn40VHW2uA3z2TiVSiWBXg3CT9a4SA62htnp9Dfb8Wr9b45O9dhgk8tIg2ziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720125567; c=relaxed/simple;
	bh=aNSEBF1hRA0wxDuvbggdqe6wM4da6gyvvuo00d8kyNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/UEldOTBXMF6mD2uDKuLYieoX5CP7n+fZgGJCjkFM4BKipo2WB1HA8ih1rmCl5u/G/JUAAZkLsnkHnwZU1fj1zEJhj0yBPA/JYDQxfOuoCqoTHyjpaconn0NFfjrPKzCfGtxx3A9hDjSgkU8MECDEvS7O41n2KFG/+SV8/26WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=tnFgOhp7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720125554; x=1720730354; i=deller@gmx.de;
	bh=Tk3AyCZkg/AValzygKSVQ+XFUjF+n1p9VhE/pNWvkq8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tnFgOhp7zPoKNlqrvEOO7Er2mYKVVEHPLHlKzINbxxLmmamdqHQQmPSx8Wu+PSmk
	 JIew7E94SKs9W1go721opS+4eLEOv03m+qoNvrqsU2EFp4SQmf/WFLFHcUEKe7RJq
	 Np2+x5BQPqfqu268EZqgvC+yQz6QTqwdA3bTU5OrDJc6i13nhBs7nKKBePc09rRqB
	 966Y1jhROHHk7wdIMe+JoaFCdCh7GXhCQQkDWQEpqUOXePaBjD2t3vswA7dbJ6YYp
	 0mWU5XlmU5oNB3c4FKFX01s0Ekx7jB9eJJ0u4BoZxEpTwoO+NFAn7WS8qTPuPB/9i
	 C8FpNplILMJKP8teHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1rtBTz3inW-00dfOY; Thu, 04
 Jul 2024 22:39:13 +0200
Message-ID: <39546399-7b33-4fa5-b33c-596e17cd56b2@gmx.de>
Date: Thu, 4 Jul 2024 22:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Use max() to improve code
To: Thorsten Blum <thorsten.blum@toblux.com>,
 James.Bottomley@HansenPartnership.com, rppt@kernel.org
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240704045133.32400-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240704045133.32400-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5A/x5IwYapzfljXHqL0+tK/ieyJ35pz6r11l8SqYeDzjSiNFUGR
 hf/KGcueWbe4aKB7Z2Y4H73PPEXX8B0jlihcxr1PolZTsUpYpWmOUfMxTe0r6sqqu7mu7b9
 6uVs8z5RY+DUjV1e+hYi4krRxaJa4CN1zpxKz7yrr9S+q8/oDlKwuT6PJ4HyZxuhF3v6cnd
 eQRTDmaHmh44PdLxOGWeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:skYbL7Fqm6c=;18ZERjUABboY1OY8VpsqmwHL0ic
 DdMBIfDegvAsJoHRZI41UNjUrAYFtUngC/dfyofIdzSpLwApYM/6xSwXIoRU3PzbnQypb67KI
 8QSqkrOSrgoSqyhqPy9UeU9MplIeq9AGmYphuV6HmD2bcaRYPLAtwfTgkCm3QpjlLIhS5/cpJ
 n8QG1V+nPss6NLayBtTffREusZ7hiYwOPs1MQrCtWWNVEEbaSFhST6ymysoZ/nLu7KyOTVwE2
 VjorkDF/3uPWsR+KZPV8O3R79HPthVfgUjZV0qJ5LGkHO4VX9KtQnnub2C9NWVgUffXIDxBNn
 9krlpThU9DZDuvdYWcnKvNWqHPzZmnxKXQjhjNmDVNo27kj1SQ4ubkmhc9vTDM0B4Bq1E5wpu
 rv1PcqE9RX6v+TKQPB90sUI3MF7VaZgo4y5i65n2j1/jiZd58KZYn+SbWF9IVq66Njz3fiQtl
 qZL9Ld05K7Jzn0wXrIIPI17uTVKqhVf7NDbkLbIPUyZIWGjcVTR/0/PFy3040Lk/sNpCI/Uwx
 9LaxACTyJnHG2NtQoVwnm6g75F0jgTjL40otGGfuz+meVR7T0B7KhHmjWhftjyoi+TYjNnWZ1
 /zyf2qhhXDajJImMGYcAx6ixwH2xDwAsq4uM8nDOsaP07Mb6Ex4nTe6WA2i70YcabeZOpWMfj
 T7/N3dn/2Ar7zv3NTMmD2aorAcGlaBPE+dqhzjUz+TiJ+pCWsCy9B6WznpMEdGyYaEe+j92AQ
 zSpKPNRFbvOgl2Xv72xR/mPkDRzzOENAc0tU9lGVrzwslkQHPbBHlwi/r8ByWBktTo6lhylU8
 clZaQcavzVsXT+N+TI8gyFWobeMvzDD7iybe4NdNoKhok=

On 7/4/24 06:51, Thorsten Blum wrote:
> Use max() to reduce 4 lines of code to a single line and improve its
> readability.
>
> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>
>    WARNING opportunity for max()
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

applied.

Thanks!
Helge

