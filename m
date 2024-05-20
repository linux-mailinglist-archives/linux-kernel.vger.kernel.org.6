Return-Path: <linux-kernel+bounces-184213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C78CA46A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F923B217D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213D36139;
	Mon, 20 May 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGlturNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4E1C2A3
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243999; cv=none; b=fFBLBXQ14S590o/yt7xqmRs1WZXCfy/ohUjv9aYce33WrgMF52wa/l3fOxSuc9kCFI45PSVtJAXhvQ1mdg1DZ/3hWNrqoa4qa3jqsnc0cFsepLIh4eFMY4PbMrDoSRrMC64HPpw6YAs4XAhoK8q4UpRQP+5lG0tJHBq4uk8WmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243999; c=relaxed/simple;
	bh=gwu5FyuHCMVc0xOUkh/7L7e4biABQM4vpY8lMwY95hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chtd2po3gC+h0jJzKsPg2jETZln6nYElXhmesQpnOGZfYDCVF9ha7sbaSIJnIRsQYsvQ8CwqQySVQmiXCz2VeN0S2InD0TNJlpAKECybRt6F1nzCIdQMkbms6oY24Pg9OoAwIuHi7e0lkXANJBtg8jLyVv0HQIzWJp7sE+DONvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGlturNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407CDC2BD10;
	Mon, 20 May 2024 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716243998;
	bh=gwu5FyuHCMVc0xOUkh/7L7e4biABQM4vpY8lMwY95hI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGlturNPkIfEQkNGjboR3s1nlMNlWitEe+OG65p+glP+HdFP/APv8SitdF2f1GGiy
	 40P/lOQ713wfV+7TX1S3s4cfhJaVcMA796P/pQLWXWK+BpKP+BiBpjpFCdQH+F4H6J
	 LAZtn6snog+QfuyCMB1BDPyZmkHBoY7Nxd+d0RKNes2b98kLhH10KJ40+J2gCsVP6s
	 YT5XRFJyuhKbuSmIJ1LoCpgOd9Kkgjv5EwDEyRntfSCSaE7VhsPqIi8lESCbn+7Koq
	 hf6P0JEeyF6FaDJa8qaBIevcN+u0nuMSFpO6rPtPDgHxUyQNPmpyTDLJ3pbOa771mT
	 xTDJU1ZRKzNNA==
Date: Mon, 20 May 2024 15:26:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, Alex Elder
 <elder@linaro.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX_CONST
Message-ID: <20240520152637.065bb8a8@kernel.org>
In-Reply-To: <Zkuksm3K+pKugjgF@yury-ThinkPad>
References: <20240515172732.288391-1-mschmidt@redhat.com>
	<Zkuksm3K+pKugjgF@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 12:29:54 -0700 Yury Norov wrote:
> > A simplified example of what I actually want to use in a driver:
> >   #define DATA_SIZE_M GENMASK(3, 0)
> >   #define MAX_DATA_SIZE FIELD_MAX_CONST(DATA_SIZE_M)
> >   static void f(void) {
> >   	char buf[MAX_DATA_SIZE];

You need a "+ 1" somewhere here, right?

> >   }
> > 
> > In the implementation, reuse the existing compile-time checks from
> > FIELD_PREP_CONST.
> > 
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>  
> 
> Hi Michal,
> 
> So... FIELD_MAX() already requires the _mask to be a const value.
> Now you add a FIELD_MAX_CONST(), which makes it more confusing.

+1, I think this is doing too much in general.

