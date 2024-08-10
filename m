Return-Path: <linux-kernel+bounces-281964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3594DD89
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ADF281DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EC16726E;
	Sat, 10 Aug 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl5RWHJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE03FBA7;
	Sat, 10 Aug 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304901; cv=none; b=H+TB4QhGE7kCi4J8FpeIxAcHwZFZK/JULya34lAV/5H9Gy/8eZDpOmEhtBNRlMRlXMeiZwpxr/cnE5Om1rIu1oOXhIXy+Wc6oDPT2aQi9odPvx/ixbJndyth+fy4kn1qucQPXD9KcB00CH4gJeAmyA6+EFLZDseeBQie/5vwVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304901; c=relaxed/simple;
	bh=1mAtGESyykUC9Vn380/lHmjiyvC+ZvrqV9V5pkqJojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOi259UjSLM/O5Q8sxI2Qu8iTv0sUHnC3tqpvAYRzNk8vG7DBI3fi6Qaw85/xuLMr4Eq/1tiaeB7LRsmsuEIrerZbV3kZssBohxU1uUN0UZw0ps4kA93T5BM7qNnCkglhTf5n7XHTihXLZetT+03hG+eMsZ2xTrnQJU+ymRdRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl5RWHJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C5C32781;
	Sat, 10 Aug 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723304900;
	bh=1mAtGESyykUC9Vn380/lHmjiyvC+ZvrqV9V5pkqJojQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl5RWHJGJI1i07gLx+WNooSx9aYkVURYbw86gfHsiaVi07o1Tfz2fdApCk48tfrmt
	 /j6GE8z4Eqi9Z4gpf+DAPjlZ8noUNMNfRqvs1611N9hJRZMsyyM6aof7SEd8b746E5
	 5cZu51tPecpFVsHhc66dxZdm0pvdjYGHBJNHlDio=
Date: Sat, 10 Aug 2024 17:48:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Translation to spanish of the documentation related to
 EEVDF
Message-ID: <2024081000-drove-catatonic-692e@gregkh>
References: <20240810094348.13745-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810094348.13745-1-sergio.collado@gmail.com>

On Sat, Aug 10, 2024 at 11:43:47AM +0200, Sergio González Collado wrote:
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>

We can't take patches without any changelog text for obvious reasons.

sorry,

greg k-h

