Return-Path: <linux-kernel+bounces-190290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923428CFC76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EA41C2185A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A212D743;
	Mon, 27 May 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ogl7VKwz"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9ED433C8;
	Mon, 27 May 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800887; cv=none; b=pCR2ZitePmEkPuLDGkJToLESW4LuNhLPCEHaX5VxH1GWi6epK8jUXQ0SeumOn8Xc4ieleuO9ytjbYV4YTqsM3bKcgwANfk+iV5Qv3Rhufdrd1osD57cl1UboOmjT5hl9BodVzaoaZ2wELSkutAagMawRKOZA7IzLS2c3hqOg0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800887; c=relaxed/simple;
	bh=SNmeK7mCWTtFSvWO8eh0/lnLnjP3/m8V0C0ApJhbfYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX2UdV0fLaLsWno/+VX2v2xpkScrAemDgssTj0XlFYH1wvLAHMv2t/LmqmAxLLLYcfyoDOAXbLQvASrt/2RoSxxgPHhrrRzQf7RxGohYIKvH7W0NWQiZTlQ6t9GcTlkULWzGbD3whfp1ZZv6munGtuOX6pCCJcAbYDlHLvlXfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ogl7VKwz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716800863; x=1717405663; i=markus.elfring@web.de;
	bh=cQmjal3CjS/j+6M+2XYTIrwdOTGkVSbVdktpb0tEJ1Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ogl7VKwzEbqPYLbKarHyZcbWvGUqfFUr8Ca2b/xaom/NHzUeFoaGb16QiFT/W6uS
	 bhAnjYXo6VEDaYXj8R7erFdHDFc7d1M7/OiIpQ7tieAwLVnLm79dqoCe3SlSSU5Uz
	 9DTXGLFzEieAKXCEMnZFg/8l7QFIdXGveTKtQ3lmfbNX3h7BbYaN/Mrwgf27QWu9G
	 hC8pr7gBJr5r5uzjxRYZK79SC7tCBP+7GCL0NURrP4vkn7RFHmtyctrXyjyXvLCps
	 PDY/df7+p+Be/YzhlCb84Jtd6Uv3Nv7jIHptMvMoF4VAoPUdkGL6LdgCZebIbrdgV
	 afeCMGEs/IeDdoZc0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vRm-1sauyp37Bs-010xJV; Mon, 27
 May 2024 11:07:43 +0200
Message-ID: <6ee0b36c-5ea0-4a0a-9d30-865f5b823e78@web.de>
Date: Mon, 27 May 2024 11:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/loongson: Add a helper for creating child
 devices
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240526195826.109008-1-sui.jingfeng@linux.dev>
 <20240526195826.109008-2-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240526195826.109008-2-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fuak37MKdt1gdQD3nd04PvrGf9PL1iGX348e3REJD+6AlRnnm4i
 H9i03KpL3MUnrdt47SQs446hFV10lycuGT5nmaqo36Bc+hdPZ1nqQDEK88yYhae24RJbrqw
 j1DT3hB0OKdZPo7gB8bNhfybJE0uZDjt9oupAP6FiLJDb/3h/X5xictayypvsAmq7SIcvE7
 AiK2U8XMEPG52POAFy4TQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VxbJ0CWmErI=;qQHNln+YdOL5+hTp4xFs7wOhdNy
 BMgj1Cupf1AM7vTsTmRw2ZSmOQdGUHcMQmleC/pUMNIegxO+qXek3mKE5+Y6Pj+v9x0dAa0+Y
 UgFDK7rxsBswrsjaLOTbJjy20AmRmA4jOef6O8SX0/EvtArHz/1WUHsN2GSbLYoZ7hbzV37eI
 gnFjuKZX9CkdzWIvYelT935uOsN2WwwS8h8jaXMlveNJZ7wqYlFheCdrgMGsHqqcQ3oiPkBXo
 PkCkv2VDB3bNLOg1YRF2SUkAEQUqSsfMLXcY1209FXOPJ+pqlsLjwiuduj+GmpUrOzMz3A1X/
 2X39BmEG9Uvx0P9zkn3LLo0GyvHTVKqn4UQmviWw0OjLlTtbgUZQPRJXiecKIeIonaGmdSLfx
 8VWdiwjRaxnogzL/dY5nqb+KSiD1tHXOpO7s6r1Bg8BZNdpdREnaoNeuXjzh887SYUUqaEL1n
 nZw8hXDz1WCgeHaHkuAv03Ukhr1jnXuPfs5iYWBuLrqFBd4YmVkCgya/vvWKKff7dnHoO3dhc
 PL8clYoUdsvcvCsAWL5oCY/x2DWmSMS2uaanSvGyD/PbPqHft1wEWPWkeAGMz8HG3XR4TZFaC
 omXr2oyXGCgTrZfjRGIhcbT6xbFaAS0h8iH5mBJoVLga0x9OzI6UkjobdmbEFBM64RxoQojtu
 auk8E1tBq4FdGmjd5ydVv6iFL/nes6AqQbxpNm5wxHU3m7uZhq8eC07IXfcMpR9V0uC12nX/k
 rv79ZlJV6Ku1f8H2NxYrh0ShB/uLwuWxaiSYjzuARKCckMbddLL3k34XDr+hoo5Vr3L0+Wswo
 Mq89d+XGjKBJ+ltSkdNCOY5g858ZoY7ew52hn6qAK0+jk=

> In some display subsystems, the functionality of a PCIe device may too

                                                                 might be?


=E2=80=A6
> into child devices can helpful to =E2=80=A6

                         be?


> Another benefit is that we could migrate the dependency on exterinal

                                                             external?


=E2=80=A6
> and rising cyclic dependency problems if not process correctly.

                                               processed?


=E2=80=A6
> driver to create sub-devices for it. The manually created decice acts as

                                                            device?


> agents for the principal part, migrate the potential issue to submodule.

  an agent?


Please improve your change descriptions considerably.


=E2=80=A6
> +++ b/drivers/gpu/drm/loongson/loongson_device.c
=E2=80=A6
> @@ -100,3 +101,44 @@ lsdc_device_probe(struct pci_dev *pdev, enum loongs=
on_chip_id chip_id)
>  {
>  	return __chip_id_desc_table[chip_id];
>  }
> +
> +int loongson_create_platform_device(struct device *parent,
> +				    const char *name, int id,
> +				    struct resource *pres,
> +				    void *data,
> +				    struct platform_device **ppdev)
> +{
=E2=80=A6
> +		ret =3D platform_device_add_resources(pdev, pres, 1);
> +		if (ret) {
> +			platform_device_put(pdev);
> +			return ret;
> +		}
=E2=80=A6
> +	ret =3D platform_device_add(pdev);
> +	if (ret) {
> +		platform_device_put(pdev);
> +		return ret;
> +	}
=E2=80=A6

Please use a goto chain for common exception handling.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

