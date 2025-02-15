Return-Path: <linux-kernel+bounces-516413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA3A37100
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AC16FC75
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27A1F890D;
	Sat, 15 Feb 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Rnb111bk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B1925B8;
	Sat, 15 Feb 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739658168; cv=pass; b=IkTK5wod2YOMRQqjikEoqjJ3yh+gdCJjmV0XxH8RlcfG85T/bUi7/BAbhwrZT3LWdCk4vF/vTP1BkyU6j8LJwZharY5YBHOdkuOc/bXpGxAC2QYtPzlnzHv5lnkyXC+P/kO69W41blCFSIcIZdPjNeO4EDd0NuftkPsOIiV3rt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739658168; c=relaxed/simple;
	bh=RQ86hVGMaawz0wFfk//wpdYKXxYRWrediwD2ebKn0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+A34X/o3XqNSvEZdxWlGZNnkHi+x8HcxN/VtIgAuXz+wMWXs0pIeCs5SmzPmRU16DhoWyW0jZdxdYvz5jrS7SvfFwXM8Hkc3XJTNw3Ltj2T5OfgCMTlLRRIX2P3Nt1wnQM2BVBizTa2uCBp3548Q+jRxnie+j+uJOu0+z9Vxws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Rnb111bk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739658154; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YmF0IvhOTmnh1dWu4RSf+qquro+asXnI7k1O/zgivywQaFcyAfWAgGtqmRkB8E4ja9BlsbhgxhMVPz4QH5p/QVXgk50ywxHAxCCVFS9CTK0t+Edl43GAFpAilIyuH5oiH1OT/VP5bX420ESoBJKKDjbkOHuptQ1hbHzEU+F9aTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739658154; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YVueEXeSmiJbNmR3RqJkm1geuIWo49OFRoKB4g004mk=; 
	b=HrZzDYkI0zwBMDxtIjo2KLRzOW0BD8Cg3l1qSdT2vHE+dgKEqhR+YxXCbPZCw6vfZgrbnV4g7twlYowwV2yGxK5IbHvjlhqKkJy3VjBLeGhmE7SKDZDbdcyDTddDqrV3++Er9NNtY3eHMdF2zb20aMTT2N/37alqbLEiHG7frxs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739658154;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=YVueEXeSmiJbNmR3RqJkm1geuIWo49OFRoKB4g004mk=;
	b=Rnb111bkeEICQFLq0dYD5MIejs26GwCkuq5M9aND+MgbcpqucEwp9vhFSzWfO/22
	x+fhAMxpAtp2Y4/AX+kyJMl7igyFOYS6PjiDEO1L+4pXinoMS8HYZsAPdrh9l0di2e3
	WAMIbW12YWs/++UhXQgoRisIe/S39P8bsRUngPLk=
Received: by mx.zohomail.com with SMTPS id 1739658151880996.3267160015083;
	Sat, 15 Feb 2025 14:22:31 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 6ABFC180CDE; Sat, 15 Feb 2025 23:22:27 +0100 (CET)
Date: Sat, 15 Feb 2025 23:22:27 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Message-ID: <ltuyyul4vqyavsqvaue25tdbtjzpwkmq2smtsedidgyomu7d4w@rxsxbdgzheba>
References: <20250215152550.3975614-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215152550.3975614-1-liujianfeng1994@gmail.com>
X-ZohoMailClient: External

+cc Piotr Oniszczuk because of [0]

[0] https://lore.kernel.org/linux-rockchip/C81810F2-6E9B-4DCC-85D1-CCB63CBFBFEA@gmail.com/

Hi,

On Sat, Feb 15, 2025 at 11:25:45PM +0800, Jianfeng Liu wrote:
> Enable the HDMI port next to ethernet port.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
> [...]
> +&hdptxphy_hdmi0 {
> +	status = "okay";
> +};
> [...]

&hdptxphy_hdmi0? That looks like a downstream thing and also for the
wrong port?

-- Sebastian

