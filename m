Return-Path: <linux-kernel+bounces-336326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E081B983932
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0BA1C2182F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADA84A32;
	Mon, 23 Sep 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QsDhEk4W"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A378B50
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128064; cv=none; b=O0iJ4WHuJd2n7cEXaCWoI+V1sTg9KrABh8a8ELm2fWDGaKCYHBaS2f9K3ux5z7fBDv02GCZt9eSgEP0HBanAPqyFEw/JUvXMnlxXk6cNSheYrA27zj7PibIDmuIJHVMFKR8uEf6+Cg8xryCs4fRZqRxviIkW3spxoac2QJmCxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128064; c=relaxed/simple;
	bh=zxTaVKENhPJI7N7c40d3YaU/flo2B27+Y3TVIxgx7zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqqFD1Y5X8i2+BUhpyPL/5VeiuNoZ7JUb8/ExpzlyrLZ4UOHbKoys2qJKPk1G7JS+i+1LYPyqpkfocEUQUx/5sv6AjaRfzh5sJ38apm+8SZPPTJ0mLA5jsAfS7Ly84CKzRjeJKowE0V9MsTJUwV2CklOWHbW7zZ5cUkhk3d8nLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QsDhEk4W; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 17:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727128060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5crOLV50+FOau9JbBcyaPlO6pi7zIJl1P1gL9ee/Xo=;
	b=QsDhEk4WHLy1FBgJ02jTgo9NaIwF+Z7VR3wFTIQMPORJm8UldRxx73QJhcG7i0pVCukABo
	6el2pTmjEe0mNWXQ1T/ZBRsoFyd7RozhOAgmID+KM0VuGCJEOogAczToxKtOwbdNx5PUK+
	klkiN4FpSE7UKInFHxewU9SUdFXMa8M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, 
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] bcachefs: Remove duplicate included headers
Message-ID: <bsiwbsyxdfiq5cbyzaptcwzobxdu75u7uy642djem6tjddvk5d@6ylscc3jx3lj>
References: <20240923142028.232365-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923142028.232365-3-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 04:20:29PM GMT, Thorsten Blum wrote:
> From: Thorsten Blum <thorsten.blum@toblux.com>
> 
> The header files dirent_format.h and disk_groups_format.h are included
> twice. Remove the redundant includes and the following warnings reported
> by make includecheck:
> 
>   disk_groups_format.h is included more than once
>   dirent_format.h is included more than once
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied

