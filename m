Return-Path: <linux-kernel+bounces-221790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9390F894
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3041E1F238F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0015ADA8;
	Wed, 19 Jun 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="vZD4wRtj"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129CD55884;
	Wed, 19 Jun 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718833298; cv=none; b=WQwElWzly/J/61Fc3IBzDwgjwUVF27dHQFe5JEPX/7E8HGPvEwgdbEYwWcOJQYGRZB79rLO4ndwH6saTfIZa+KipsFKhMs4Z0/tIinAC4m4OBOPwHX84XH8r2L2Uoke3YurnGBK+1sIhKLMz/HWOYu3QbJMvS0yDxH/b2a3psro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718833298; c=relaxed/simple;
	bh=eVtt0YdjLg0IGVqWIKIohR6GBsnh6CM5kt432fy1FxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBRZqYwS2X/3ZIeiWoRr1xrb2qsIEboUtcvPGuLMI3S3EjkRoUyYAL30L5X/TYhcnM59AHu/b8st49uvJmxtI0UIkRMJ7zViVcVwJLKcGCKZVzrAD/2qi3yiCrOXm0TREt3a3N8ybfNfaeS4lcz7wHHtgQQB1FxGi5ApCkArG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=vZD4wRtj; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 193861770B1; Wed, 19 Jun 2024 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1718833296; bh=eVtt0YdjLg0IGVqWIKIohR6GBsnh6CM5kt432fy1FxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vZD4wRtjKYaBcHF/I7yEXDZdTMa756AYjyOCdHD/T3LHtHvhkEDTX26o8xYQUdlYl
	 0s672KUu4ErW4Iavnw0zM0PpGyRvRTtdtYYlL5K1NDCdP94MczIzVkZpOF1VHaokfl
	 vBsBKuaT5LlalGjsZFUCBxqp2QflO98l9VQYC5ZHvZM3cjxu9RlK035owWZo3cPiL2
	 Civxx0lOdD2b2TiEqvLUItAeNZarMxb/sPES4cY5+MsenU+9OMb54T74jc9M02ykHm
	 NTrvXxD5v84h1xBsSG9fcBR3WwBIMOg9KWbySV575C51Culu746o8zPof7nHdIJ5Sk
	 tu3Em/vHuquxA==
Date: Wed, 19 Jun 2024 21:41:36 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] English fixes in vmalloced kernel stacks documentation
Message-ID: <20240619214136.GA3571068@lichtman.org>
References: <20240619210707.GA3570474@lichtman.org>
 <b6dd319f-4de7-42e8-a06e-a54633590b29@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6dd319f-4de7-42e8-a06e-a54633590b29@infradead.org>

Thanks! I will include this fix as well in a new patch I will make considering Jonathan's comments as well

