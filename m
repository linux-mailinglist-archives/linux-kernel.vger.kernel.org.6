Return-Path: <linux-kernel+bounces-197744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC88D6E96
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C6F1C21909
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300401400A;
	Sat,  1 Jun 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nv16bLFO"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D31FC1F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224789; cv=none; b=tLTmUbLw2/HiPuY6g0fvsDV/YAmnZ8ZFLuivbi81YxkErsAoVptLI2c/V64V7w666YZsLYnsOGuYo+rNdGblLyE/cx0S6otDgoUAymKPSrZJ7BWvv/ItWHd3sgUV8JoKgK1SImTdvdzT/X6cH0wM998vlfpbOKkzposXpp8TmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224789; c=relaxed/simple;
	bh=JImLXNX2vV91/ze/yqvjMib2KsaBe8CFho8OHUC6B9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I74oyusy617Bjcplglfym74u2Z1Oriyn5+ykISAG7J7C/UPcDP7OuhGJZsMRl6kST35g+/sJn0HBN5Lg+VhCr1FtGgodVenVII7xpsXM6/A/h1V3N4AtGRu0gWjJt0Ru/wEgDfYuLVte3y0RC1EkFUjMEiGa3VAR2j6rW1dyXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nv16bLFO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JImLXNX2vV91/ze/yqvjMib2KsaBe8CFho8OHUC6B9A=;
	b=Nv16bLFOI2r9GzIyH/e69wJ0pi9u1kBY6ugMCo8RFVLSaBdKmyBp1p7zN8cWIgssEy+nwL
	039KnM3Vi4hC4jKeXgPWmb2QJCMT1E9iLELrT1N7kc6wPy5yjthDN+7hFPZaWhFZmJBWoX
	4fJw6CTD7HcXm5srxmpnucv+BVE6pc8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:53:01 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] MAINTAINERS: add mm/memcontrol-v1.c/h to the
 list of maintained files
Message-ID: <p2lakkljy46frgvhpa3mo2o47iqjmc5gpjhamx7zgpziwwqekt@3giywbnsat7x>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-5-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528214435.3125304-5-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 02:44:35PM GMT, Roman Gushchin wrote:

Nit: add a simple commit message even if it is redundant.

> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

