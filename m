Return-Path: <linux-kernel+bounces-418354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190969D60B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF4FB258BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE876036;
	Fri, 22 Nov 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t5SCQr5M"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294A3F9FB;
	Fri, 22 Nov 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286778; cv=none; b=eZZlwPOP0mWa2zkmHiX5zTATRXra/etxDCWTKIGIGAwgmX5m+EAnY3UQz46P+1TFSOV4ITnQ53vtJCw8oMJFosZ6vX9k0nUkWBT1hp6omjBD2I+1Et9vx2hvrzNLg8K9kyeUemvVyyqnJpjw7VWgVJb+N160kVtpo1LzRxCo1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286778; c=relaxed/simple;
	bh=uuKUsOajQgM80O8VvkAX5tv435pauF973/vP1CI5xTI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kZTUOQ9oglmR5PBRZkKUay497v54X/Nxhs0+K6FUilPuaQs9dBiUouKjCY9pTJzRAt3qokY/tOwiUSHvyuP6H3TdL2CQb9yUd4rVWg8FEvgHN3QUd9syLw5N3u0IJzzRTNgtbRToLZ1IoHcu4ZE0xtl1MCWjcvnbmBFh3QdrfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t5SCQr5M; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732286759; x=1732891559; i=markus.elfring@web.de;
	bh=uuKUsOajQgM80O8VvkAX5tv435pauF973/vP1CI5xTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t5SCQr5MlXPwnj62/Gu3Q3slJRtRyreYUSLX9imsubMTJ1jMhYo8MRnGZ8a3V/Yj
	 iYcUAfbAt/0wBMwnz+KezgWXwK6J4yxGFe3tynO6bkyomTBJB9qIMvA1TJlIll4Rk
	 w9rNUrDoKXDhxONNBXLjqsw2TgQvVxEjTY/R+tSM+wdvJNDP12BDKbgvau6K/qR7I
	 qfVzUE+EsnsMfMwWCt6k9yC0JLs/X2cazHrkOczGFYe0gU2kZtfyjcBT42uS6VM6t
	 BRrAUd6yfio5OLZDrIPwwngRgPNazspK+xBIOiIQawniaSH/6L/tW4/7vqfzE+Hh4
	 Der5O+K9V0N5jUJSRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1t0ocT1BHC-00MWE4; Fri, 22
 Nov 2024 15:45:59 +0100
Message-ID: <a5f7928a-1628-4e37-9a49-07e0562ef463@web.de>
Date: Fri, 22 Nov 2024 15:45:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-hwmon@vger.kernel.org, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241121-chipcap_no_iio-v1-2-6c157848a36f@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (chipcap2) Switch to guard() for mutext
 handling
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241121-chipcap_no_iio-v1-2-6c157848a36f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:42xoAbuinLYVrB5vXZkPFcB8xWPF9XDfgxX2ZFC1AYAHhCIkWrR
 UKE25j66jwJRuP84w5kSqDhKYPZDtS17zCrtL9T0knl9nXyPEAKJu1V4YnYbf2UDj+AEkhg
 mhdA0Rqs1b165kQw3OtqQp79Sk31Z8byJlnxnD57KNppVTdKzAq/z2Nx2uAwnsG2OXPvP6G
 gUorEipxzhsEptIx4iSLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zTuWA0vXtrs=;9C+EBkwKGMKdQ/TCtVN6RoI6lWg
 dPkTYP2E5/C5H+uS/MSkPSd1s7PixlJAg/lkNuE/Qa1gqoA9MmJb7e0gOuVSTId36tvvPvAeC
 rfEetgaUT0QHakre5z/HuSOz2q1aHxz/TjXRCRvfDJzssG9yUrCm/uVJBA5l0pLsPfjj2jdel
 jSUzqWt077YPM9lyVmFsU6SDwEDTTTOZTbnNrO+HxtwRWcny55hi7Y72buwKZ5zVPcNyN5SiS
 s4JdqXJGUdNj9yrQNWVGfQkbvFLdAYbgTjhdnWtvdtTxQ5rvoElq8YEhi+6fwecel4apbI/qh
 ZNpI7K08B8YT7YsfhDkT4zI+7I3bpH/Y1CyLc7Y0TZl64Bi7xFVu1qgsmXKPy+EOUsg491moi
 hu4gWvZ8SokuNwMpBsrLvQFq1E4iGqEsptgeaJ0SdVvyAFgOIfU0YKf23J99pbMcF7m8iQZg0
 OWg0Byoj8VTpTbU+k1ZJ7gQdjtTUUQqO9q903+Kq6iw1tvQdaEOKM+O9ci72L8ACop1TrCTx3
 jptmWfbQz3dBgX13M9nPdaQW8+WzgMmjtW/UWPahIzh++sqSu59RBJ+PUMojpQceQNJELMm2A
 gf0hqdKdF7L3x66xhAI4wg7Zv4GNtCl0xk1UWuYOefFOZZpsk387HAUFFXjj2zLmnRcWKI2S8
 pP9RZjbgGLmQqMSs2kubdZtENbQkqYCTdSSQhU36hsuMBc2BKJ5q+fSeIf+hti0x13m3e0Wns
 zNqHiHVnmOfgzvqAqW5dUtPf8A+RANkkrJOyoud8Zy7LsdnOXwSdyUULFDEPhclNFjtIFjL8i
 wSVJfCcx86vWdJkC3oevBZg9XrWjxmWjhcXL355Zxe4IJoK4GAZT5e5NNfNinClPAL6h4SK47
 L4Vf0kr9zP+2zHC88ZUjMUOQ04EKS088+XQyhsXEijWL3v4kcnXxR7+2araxrTpvR/5HKqHgc
 Kne76cGOLPyBGLEF7uCnB1npamNuLOK5FDk/6sLzGeZntYtzEQj2wJVlRz0n1j+xOVF2masly
 WiNzHcdbEX9At22LkTd+Szt2O25uIYQKku0L1/aWifW2SDiuOc43xkD+zfdLmBsp1WpORxFOH
 Ry2mkocpE=

> Switch to guard() for mutex handling to simplify the code, =E2=80=A6

I suggest to avoid a typo in the summary phrase accordingly.

Regards,
Markus

