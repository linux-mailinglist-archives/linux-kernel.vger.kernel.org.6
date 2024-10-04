Return-Path: <linux-kernel+bounces-350655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6C9907D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F3D1C242AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF41E3DF2;
	Fri,  4 Oct 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ftTsGfN4"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250801E3DE2;
	Fri,  4 Oct 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056037; cv=none; b=YUu+RzCkd8b/jhWVxTeCYhOB95xvcTEQTVWgmG7BR8K7I1ujx8lpW5nbyrR/m8BKHpJgrz++zwkfiuXNJbqopT8LUPMaaog2FSItCFEYgiFZyrIQ2MHnvSeIlXIY6JqUbva0ubd7pygpe2GwjBVwWEuFUD02sNvYHIktlNKRlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056037; c=relaxed/simple;
	bh=gjncOFNI91eE/i9qLENcL8qQ6qRD2jzz45Htiiwitc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5hqwFjUgOd66nzYsiFOWuFQll2S/2PSkpX22w3Btc4NNLCgwfK6x8L9Oz56Aq6P34rZxseHE3j+bDt0j8lC9LNIlQGVMYd6020B36Peix2+h000eIFIDMReR+CfYM19M2nkhFIkXv2G6s5jOVnQtpw1l+7Wp9QWiIuUocckvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ftTsGfN4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728056028; x=1728660828; i=w_armin@gmx.de;
	bh=1Z1ETLMKssaKmHzYJoUrFeje1fnlvjKiRYyIrNRHGcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ftTsGfN4uw9pdGsd0GGjYXV+PTq0MANkuCUYe+PTm6yNwGXlDkMfUdLn6kaAo1Tk
	 d0oUStA6e0uP6O+uqGhnKmVb0VqoQC1AiVndloiQRRCvq91njss3YfDzTv1B3u2+/
	 aTyOPeR2t5NYbHbnCmKG7z0xmezmVKv9ojWBwF4FucycwYbwP8JcNFQdMD+lno+ka
	 y1emKFq8eY5dk6p5Z9p90YxayaQzixsyjhbeMDNGSvFzSXCtrp8F2ioUh9hX6NJeb
	 wopwSphZ+j/l+kDcQNSJMTBxHtMi9vFUAJfnHHP1VCz+JGoRKwKB2Cu7Z5X1XT+QU
	 yq0i5zDhEal0aLi8CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1tudFt1nCr-00uoSY; Fri, 04
 Oct 2024 17:33:48 +0200
Message-ID: <d42910eb-3353-46e1-9a20-ac68eb0160a6@gmx.de>
Date: Fri, 4 Oct 2024 17:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: dell-ddv: Fix typo in documentation
To: Anaswara T Rajan <anaswaratrajan@gmail.com>
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004083102.752344-1-anaswaratrajan@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241004083102.752344-1-anaswaratrajan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SY3ZMVQCxoC30gbDbXqUe2kflh0gIYgXEtHE5yS1MjI25itLGrm
 vPYahFG2Vd23pbRFE3kOByuIjgO8ARBL1svI7ianFLkpz5hzHT8gmZZAvcW/6poBNUuqEkn
 Sj3p1le8fkYqSAKpvK/scl3lOo9AdaYBHzh+I6Zk3yeZhjU9BgYokBe9fYDdcuU6RWh+K2i
 2+rvuF/BlV02/Z3NiH6fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lhuLdilrsUE=;+NscgoE3IoOVsmCteKWwn9kovhf
 3qLIXIHW00N7KhWX+0VirBrBXyVNeEMru5QosFrnS7U4mcjc6yXHn3zn0DNVeaOjHBsr9Tpz5
 5M40hIuyzGb/aGhY+Dg/AOyNorNnN+hadbsYAPsTOSTLHaRQAm1O8wvci8Y8bNa9gRk8mfNWT
 uIH65tzyFKUv6KpEAA6+vcVB4bM+o5t9D1jgcF7fQnFo77ANgeTKM6CTUK6PMnhAZWMebGKqP
 WCrzzyl6km5rFTsJYFIAtFfsT2S4AdSSxy3O7LjqZFfeo+idnLUKuY6oZiUphwNcmCI5Netel
 OHyawbjkx+XteTvAG3nyqcM4c13+ubqAdca3bVJu2THkvPyvtvL7lJXPJT1jpokTtd/d/J+lo
 bTaNy3rD9cOMSPx5cbh5Ef/ySGe4lfBzVYgH55K93Rvn1rVqeyfChq3jdbvghrZEjaGruW4Iy
 B7bX0srFDC0/IG+Vcuc90EtakS8BS/XD8BYvUciqeTg6/HqLDNrjOwJM3P91BkQSnx3/dIklC
 dNy44ALcwINnGG/hYcntN7QXfOjPkemROwgV1Pj0bQp+gLeT7w52HTBmhDmDczNyXZYsyfabh
 OHXpi61sPLQ/BwhfANtw+vnvYKU6LpJBbzWro5KvOJK69U5Oa9h0pdM/+NGhrv17bIYnFIo+H
 PKDbDcDQ2lZHQYBuVaQMunU0ZrF4T6MyekMLbIM+CwOtQTUg8JgTv3/MdoftnYw3B4y7nfRan
 MPmtfRUk6NR6VcJ7fsQBZUisfvnixqrQeo/tVjeffYd4aFICjuZWk5FgN98xmPNw/Ohsooqn5
 UZwSytA15NIQn1/Z801lALqyyq3vpxgwlqkC8EWizGdHU=

Am 04.10.24 um 10:31 schrieb Anaswara T Rajan:

> Fix typo in word 'diagnostics' in documentation

Apart from the missing point at the end of the sentence:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
> ---
> Changes in v2:
>    - Make the commit title and description more clearer.
>
>   Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/=
wmi/devices/dell-wmi-ddv.rst
> index 2fcdfcf03327..e0c20af30948 100644
> --- a/Documentation/wmi/devices/dell-wmi-ddv.rst
> +++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
> @@ -8,7 +8,7 @@ Introduction
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   Many Dell notebooks made after ~2020 support a WMI-based interface for
> -retrieving various system data like battery temperature, ePPID, diagost=
ic data
> +retrieving various system data like battery temperature, ePPID, diagnos=
tic data
>   and fan/thermal sensor data.
>
>   This interface is likely used by the `Dell Data Vault` software on Win=
dows,
> @@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
>   4. Try to deduce the meaning of a certain WMI method by comparing the =
control
>      flow with other ACPI methods (_BIX or _BIF for battery related meth=
ods
>      for example).
> -5. Use the built-in UEFI diagostics to view sensor types/values for fan=
/thermal
> +5. Use the built-in UEFI diagnostics to view sensor types/values for fa=
n/thermal
>      related methods (sometimes overwriting static ACPI data fields can =
be used
>      to test different sensor type values, since on some machines this d=
ata is
>      not reinitialized upon a warm reset).

