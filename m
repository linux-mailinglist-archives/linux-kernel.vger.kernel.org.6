Return-Path: <linux-kernel+bounces-187172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDF8CCE11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E17A282616
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BD313CAA2;
	Thu, 23 May 2024 08:14:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724214267
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452091; cv=none; b=MOom4BuHalgIUS98DCKuUJQiUei6gN4XI0tfo+JvbXvttjI9jHwNXE1CPY+qldPRdwZTqjNOQRMXQfxDeMif3jxY1dUI6D7PrVoYEAGoi/ro37YiztR4BEp6GMCszOU65bl3ey2rzskDfXssz15FBiaB2YB+UGw5kkBb/O5qW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452091; c=relaxed/simple;
	bh=Xcc1ZDw2E6VO6q+cCy/cZuPnl8pMCZiZzdSK67s8CoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+LsoJnj1fO1l3sY86m4wmrRfBNNLOXFIfhF575nqPD+Ygamw079wWiUqlKlk6GssdRb79PddhRRdmsRzPgNdva7ltkX5mhLaOY1lOss11es/RLGZQrWArUsTdjak10rsxSr+b+VPVVY0xG7GC/3kDcznJh9qrNWNmgUOcJrcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2896868BFE; Thu, 23 May 2024 10:14:44 +0200 (CEST)
Date: Thu, 23 May 2024 10:14:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523081443.GD1086@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Oh, and there is really something of with the patch format.

First the subject line is completely wrong, this should be:

nvme-multipath: implement "queue-depth" iopolicy.

On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>

> Signed-off-by: Thomas Song <tsong@purestorage.com>
> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>       and compilation warnings, updated MODULE_PARM description, and
>       fixed potential issue with ->current_path[] being used]
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>

Second the patch author needs to be the first signoff.  I'm not entirely
sure who is supposed to be the author, but either it should be Thomas,
or if the patch has changed so much that it's someone else the original
signoff should turn into a Co-Developed-by.


