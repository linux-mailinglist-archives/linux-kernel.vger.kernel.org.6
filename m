Return-Path: <linux-kernel+bounces-529639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F2A42912
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C131713AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDA262D37;
	Mon, 24 Feb 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Sio8wCHU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C525485D;
	Mon, 24 Feb 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416886; cv=pass; b=UDBtoaUtUytZHNHWib26UGcdZL2QZkGyceXeKTPgebpOd7axLlnzxrKxxnudNW+70vQQZfPrupvgq+aWjdyblLvBZPWFIM8KToE10Ad+/zEDvq6Imim2wtwa+PPVcWYsWrYPZs3eMr8GQkjICYfpHy2MVX3YfB7jpIM/jsQgh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416886; c=relaxed/simple;
	bh=DreFK2+rMKeK54uU7Vp+JKJV5knSDkDL5Ya0Zl9TWiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZTqOLz9H8H9QlUUVqLAWHVAqkGFQqBpsDhMYh75LyvlN/KTUi2/Kmfpq9Akk3qH+VO+5xNEx9oO/IKSRNlnL+lY2PyGEOobC2Edkx4+HUI6l95ZT0vk2jImFkj6WjKj+2yTwOW7WGc8kzMlXpzepyBCT41FSZ2jvAcNLL2iNjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Sio8wCHU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740416861; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQsG9W64Zk2OKPd85hxSBf3MoJiTODMBTu4S6CnPlWuor7IGgJIcWNndNYTukQzzy5BIS7ko8YZuDAuCpYJal2IXzhCTBaWol/+/qQWufRn4WPQ3FoxqUTMqRthnnunXMY1EDYsQ8Ni6IH0bH9RmjXJ9VJ1ZuwMHsguCwu5Lhv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740416861; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sEPEAsu37A1qIiTQHKAj9euGoglZkXFnn7bkzdjcrRE=; 
	b=foLWPn7DIDy5HLGjNjLotNo9FeEe+uTIuAE0AjTgPX0e3wNcpU2CZSVQ+/Zn5+0V8pQkjdAozQeO9kl+ZXiYapXqxsRO/XcfP63G8q6yGydmhZue7i7pZGXZucZvt3Q/OBFQJbuWCyKqFQbJVdslHBIIzEzcXuNdG2hefJhxmqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740416861;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sEPEAsu37A1qIiTQHKAj9euGoglZkXFnn7bkzdjcrRE=;
	b=Sio8wCHUmuVQl6YhlW1D/0pbEkzPpmY28SSltsg2poGIlD72ugcjNeHS5lZoUKZd
	QvtXgPe3rWf/YjlVpGqgYacgKRrF0vd5WXdwYWJ5j2AJntdbB83gK8shcCflxeOwNMU
	rjwmLAt4nqsVMBGOEy+2FNQqstP3/I8o5MKOondc=
Received: by mx.zohomail.com with SMTPS id 17404168592031017.3373094891671;
	Mon, 24 Feb 2025 09:07:39 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id AC79518067D; Mon, 24 Feb 2025 18:07:34 +0100 (CET)
Date: Mon, 24 Feb 2025 18:07:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] Rockchip W552793DBA-V10 panel support
Message-ID: <psmfw2znti3luu6pjyi5g22bgvylcb5lms22yakfkshnol4v4y@bhzvqjbgzhep>
References: <20250207-raydium-rm67200-v2-0-1fdc927aae82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250207-raydium-rm67200-v2-0-1fdc927aae82@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

On Fri, Feb 07, 2025 at 05:21:46PM +0100, Sebastian Reichel wrote:
> This has been tested in combination with the series from Heiko St=FCbne=
r
> enabling DSI support for the RK3588 [0] (DSI controller support has bee=
n
> merged already, only the PHY support is missing) on the RK3588 EVB1.
>=20
> [0] https://lore.kernel.org/linux-rockchip/20241203164934.1500616-1-hei=
ko@sntech.de/
>=20
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20241210164333.121253-1-sebastian.reiche=
l@collabora.com/
>  * move additionalProperties below required in the DT binding
>  * collect Reviewed-by from Krzysztof Kozlowski, Andy Yan and Jessica Z=
hang
>  * improve Kconfig help text
>=20
> Thanks for having a look.

I believe this has all necessary Reviewed-by tags. Can somebody
merge it please? :)

Greetings,

-- Sebastian

