Return-Path: <linux-kernel+bounces-169394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B58BC81A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C1E1C21256
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E984140394;
	Mon,  6 May 2024 07:06:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4265464A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979216; cv=none; b=Ydv0Q8mMBqWUYmSQZd7tpMzEKz8tQxnrbtozROl1N8J3NQgS67ymVwJvPcT1XF1JMZIEbh+Zz/tqqKm2uuumXQuDmW8f5U6iNC82FO1wRy3jMB2gSyD41SpxqF24pPgeSHaFStQmsrFPQK2ziyb2ZFzSH9jESvFbY4s9lUNVLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979216; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Suqeqhkhk5BclKehEBZStvFhHFFeSr8bYVl/GSkzMa928XDRatTdngbkSl6Bz8JRsWWWgFGCLq9xPfbdVhef71gAT3fO0a+uJPSMVU+lBxZwPVtHupBrnzMzn4R6I9zDJGfi5bcqlcVa1rIWkMxoqVouc8QalFxLMpyRhZJMYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70EB9227A87; Mon,  6 May 2024 09:06:49 +0200 (CEST)
Date: Mon, 6 May 2024 09:06:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux@treblig.org
Cc: richard@nod.at, hch@lst.de, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <20240506070648.GA6506@lst.de>
References: <20240505001508.255096-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505001508.255096-1-linux@treblig.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

