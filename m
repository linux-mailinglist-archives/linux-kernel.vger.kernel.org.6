Return-Path: <linux-kernel+bounces-437086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930F9E8EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470EE1884745
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C02163AC;
	Mon,  9 Dec 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjFY/ZF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7D215F63;
	Mon,  9 Dec 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737374; cv=none; b=nMT97JD12vl4ycubQd6zATHLhgncZPBdpuNppA9SeLr8NW7zHk5RqFIF/pskGv6QPum+AqWy/1S16wsYRr2k6dbSDB/YZKO7OUMRaQVWp7VuHaCW9eidRCaLUasCp4o3jrXPBCRpNAeFxpxT43LLOYIGcuw3ZKTqGAjNDXMtEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737374; c=relaxed/simple;
	bh=VBMr9LsHSJGPFtGqHFVHYbEn1eiiaJRMceDta957bZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMASSAuS06GnJQ6wg2mvOnKpVfZ1AMauEFcPwjep10WK2qgLVaB1Rp8dYMpa2+i8z8o97+357NYATZrefe6JW+A2eSya6vrQv86eVBxUNaFhQM5x0MMTUyNlmiIfjiILfwMbjEGna1te3Jnm0wqu4X7Xr0aI8N1NE0m2P+2zgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjFY/ZF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F73C4CED1;
	Mon,  9 Dec 2024 09:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737373;
	bh=VBMr9LsHSJGPFtGqHFVHYbEn1eiiaJRMceDta957bZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjFY/ZF0biPlZzHFX8a4yRdYvSt60iFvN7mRVBcIPEcifgQt8w5R7u8h38AxJFA9q
	 cWAudzQI/acgkYf1+J+L+r7dvU920K5W/YiJz5WK2LS6UC4Ef0/H4u0fVQ6sJ1VXdD
	 WCzGCJkQ48CHzwfUmYnhD60EkHjxSeKPassSZq6yif1GON0DrBr/w0s/fna1fw9aA8
	 mKYCOstm9+BSHiX0qpbBwKt0gPF/VfyalxXYshZLZ4MkWh7CWuhCeJsZr4B2/wz0WR
	 wubHfnCOovIlc9G9HFJfmaIcPEF8do5Bw2jiNQfnx/tOU9hu0xNKdD66z6eV4WqvYq
	 2lj40laSJfQZg==
Date: Mon, 9 Dec 2024 10:42:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Update rockchip company
 name
Message-ID: <kwx76ihsftsgw3u53l33z4kodihyfcvpqpl2a2nk7aedgnr6e6@2324w7s7zmio>
References: <20241205082258.857018-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205082258.857018-1-kever.yang@rock-chips.com>

On Thu, Dec 05, 2024 at 04:22:58PM +0800, Kever Yang wrote:
> Rockchip company name has update to below name since 2021:
> Rockchip Electronics Co., Ltd.

Some reference would be useful. Wikipedia says:
Fuzhou Rockchip Electronics Co., Ltd.

Best regards,
Krzysztof


