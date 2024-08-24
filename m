Return-Path: <linux-kernel+bounces-300144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155C95DF53
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617D91C20D18
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE6768E1;
	Sat, 24 Aug 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iOilqeaz"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAD6CDCC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522365; cv=none; b=iLXbR5sY7JR+6WGDJOmSJYWRQN1mDZuxvgOyaYkkyykbuzl6QPm+SIFCP7Ovu1nmbtjRgjUSVbp68BsGYxtVWnsdSYSv+ZrM7guSr/fZl1kEaifL7ZKoDG2nvr4b8pOeX8a/4jGJlTYcdDHZYQXr1+KUBxfgZijwbujXYHPDq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522365; c=relaxed/simple;
	bh=EfxGkLvlnQVophhgVpZIEwOn6vYeBOCx1Ac+KXmpIsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btKbknDQvC1ZpW8+5zyPdgDBO96tKXlGJvWHzbtgjuKpm/PWnK6RtkQUP7BMoxjdzRWj2fyLUML2R35i+EXEdejvu4sjsMKNs72jSN44fevctF/czZmE0WxiohQv0q2ZTAeHB57Qy9WycBt6xukTKmJz7p4aAmn0alYZPMhpetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iOilqeaz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Aug 2024 13:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EYobkU7jwthVopRG5e6pdzVo4QhQPLczqWczkGXdKLY=;
	b=iOilqeazH09s7oLyjIcETAmrMU1OcrK5zdr10GW2DQcoW3WWHcoYZFD0sZYQqn3yya15vz
	AbxYeyIqyCEZ3QJwWXfqHRu1lAb4SKbqZsnZtQ0WFV3bpDSzGhSqdRvCRDRg7PX+uQwUQs
	GhgswRb2Ud6WbfGlZ4bJ28bHkivpdp4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Annotate struct bch_xattr with __counted_by()
Message-ID: <ncavolexjlz5j2uaiklynoeiuoqatwrqy3elop5f6dg3444m3e@pegucwwr57bc>
References: <20240824135740.1971-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824135740.1971-2-thorsten.blum@toblux.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 24, 2024 at 03:57:41PM GMT, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> x_name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied

