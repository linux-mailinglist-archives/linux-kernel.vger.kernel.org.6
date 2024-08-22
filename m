Return-Path: <linux-kernel+bounces-296523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A495ABBC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB4828D6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E52381B8;
	Thu, 22 Aug 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cwZslOGy"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAE37143
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295943; cv=none; b=AV9mfYFuumlLi2Q5AaX08IwlMB0DujYG+a/bhdV4rZB0wscPIVGYmG9HPFFRoAN+Tg/TYtfGZ6yVHcseoiOB5HzT5YwR3WePkr+WsMQ0hURyYzuRXYv4NsUsbcgjrDPyshtioniBV2TshknWmApGwWQD78SmWpCtJRo+R6V6pT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295943; c=relaxed/simple;
	bh=UFV+r/FdDgjmW/Bs3itLM9/eqc9N3lhVHlLcntS/llo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt2f4iV2AbXxavRp8H6yOY3ehy/926AIFqMe5fvb6T91KkS2V74jei0tUuZmKc4yRr2lp7BWdgPrcq7maK07v/+jtvEdgkO7L8PCgOzl7SsQ2WK7wnezKGN+G4hUtpsoiIUXxBFDDIfOAtMcd00QudPGMK2PO+Pw6En1X/i/Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cwZslOGy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Aug 2024 23:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724295940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFV+r/FdDgjmW/Bs3itLM9/eqc9N3lhVHlLcntS/llo=;
	b=cwZslOGyirUAR9ZcVxcEKObuJvktMNy0hQ8PG6LXId88ja1V6nHba1rIpeQCTIbcqxPAmq
	J6EYd8MBJ4xsZX4DCgJydqrkfqD3mskPOUvbFvPwLQEMnZcWY7HfdeOLjb10tJoX18+Jc1
	nnScoGPbA4erBr8AJ1DH1dTrDyQn0e4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+e199425e3ce5a18d178c@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in __virt_to_phys (5)
Message-ID: <bipsafpqx46wlf3pqexkf55goprxj6zkj3sw3cv22n5ybtb5ql@wxtb4xjdfraf>
References: <000000000000983fad061fe3df80@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000983fad061fe3df80@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix freeing of error pointers

