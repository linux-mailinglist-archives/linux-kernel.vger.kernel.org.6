Return-Path: <linux-kernel+bounces-278232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8494ADAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054AF1C211F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109113D51B;
	Wed,  7 Aug 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sUrqXRYl"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E013A868
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046815; cv=none; b=CzirU09/kmpjSPJ2MGkZ5qUBEccqB0ax/MTX2d8KVKZVQU+GTcYho9pBKtm60y9H9zH1qRCJD1Vi3sOuHQIlBMVPLnj+hgJUNQ8SGPGaxAtz7dGfAx77CBRnoBfKJlZA/xhxUGVBucwf6IzrkAZGwq8N1/cNpRu8yKTUIOKBUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046815; c=relaxed/simple;
	bh=Ox8dAYeKznv8tFNqpz7vNpNAB4UpgPt9H2/s9qBhm/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuanqKx1Vaz422Z/Gbb8NLfzJQ2JjfoLXFt5cQcdfGFhKTluVQDSbe/9xLVO7jMqSb5AB61/G9Wt9fdgiCNkqUx4fo1rWBrxH3RuRRo3IwrNXCN4v1wO55kq4H858W7w0nx3CDx7R8mqOP05elKiVYXZ8N34QSlQggHQJXla8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sUrqXRYl; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Aug 2024 12:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723046811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF5jjwkwqJB7FolX23lAfKKpsUXDA65/uxW4dbAo5pA=;
	b=sUrqXRYlveEoOCMnqMx9KJ4CdAg5HWr6M5gePcsejsvw3LpuoWVH4gju0HklT6VJ80KqGd
	WvLcftemUsqNbKbzqs9QUYfrxd8aIn8YsiOxrSJYrb4SoD2z13hBitNB4ZEIkepK0DPCMg
	dc6pdLYVh7HO2vUmVNg15jZcM0tCxjE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Xiaxi Shen <shenxiaxi26@gmail.com>, corbet@lwn.net, 
	javier.carrasco.cruz@gmail.com, "open list:BCACHEFS" <linux-bcachefs@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix a spelling error in a doc of bcachefs
Message-ID: <bdws7d7askhlctcwfgwieml56dr4vqjuvi7bavwkldjdcuzk3u@cbneggmx2w2b>
References: <20240807071005.16329-1-shenxiaxi26@gmail.com>
 <2dfa76a7-eeae-4b05-bfcd-684ae7ade963@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dfa76a7-eeae-4b05-bfcd-684ae7ade963@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 09:42:12AM GMT, Shuah Khan wrote:
> On 8/7/24 01:10, Xiaxi Shen wrote:
> 
> Missing commit message --

I wasn't going to commit this, because I don't like taking patches that
do nothing more than fix spelling, but since it in fact does not need a
commit message for something so trivial I am applying it.

