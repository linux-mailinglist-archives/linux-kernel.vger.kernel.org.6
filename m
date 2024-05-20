Return-Path: <linux-kernel+bounces-183888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AE8C9F68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F30E1C20B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82A136E32;
	Mon, 20 May 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jQSzeDNx"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E901369AF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217955; cv=none; b=FKDCcdT0KyyNDoZQOzAKWx3xUMIF2PXKS6WISE2hPUBFvJsGrLdDf+ZGjwdY27ZBwmcxdGbUQOIq1PTj7RjA/bYUDZeVbo/cx9eisipp217a/qI7jw7X9gyMrp9Tj1hJAVrW4F77soI53s1q1yMiZtAesngYBvzb0Mrxd2+HL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217955; c=relaxed/simple;
	bh=6dq7O2+449oUwfdUG8mc0oXGNGkBNFIIShYAT2cj/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOJ69WOSHvOW4na4kmpyYi9FDVgNFRRBS7qf7d7vRcfWzA6ZU0Fc7VVsoNDhwKyuVMjq1aMY4/bwt/zPGrgzfHRRoS+dIMEBefYCKZSZ0Tn1JTWzdmEE3B+84pWo97F4fOXoBs7XvSVX+IAT2isNSVQWwFVB5GTX09gUcTkrWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jQSzeDNx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=zAi31vd3hZsjgopIAPbpcIqf2rKl76gQoa8HWS+T4+M=; b=jQSzeDNxJNOxqsAm
	wmjBPSDqRLBGyfpQHouFqHKGxtovWvypk32AqSyuo3Pl9ABZuxxG83VnaZpDWWLM+Sfb72s5pzHRq
	ujf1lUvRHTx8lU2JTZytag7BuZlTp6M9K5IA5pvQpcqLoJDY6q1LtDCRIycvH6cMrcQ0X0UqWmCkl
	f/zJuI20ldF1XP1TJi83ZBS0zDmXnX3Qh9zajk8kmFKdLEYYOTYIDpn5ukNkjez5DPeWmxZigI3yy
	VlmDqc9Hrw6HGzVxg77QoTH7zfPKm3iJIw7dO6JUhEVJzHoUvqOND5OpYHxHND5WEQnPKSzlBy7mP
	zbfQt7hPVVqq7qoCFg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s94gW-001hiO-35;
	Mon, 20 May 2024 15:12:20 +0000
Date: Mon, 20 May 2024 15:12:20 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@lst.de>
Cc: richard@nod.at, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <ZktoVIG500he350_@gallifrey>
References: <20240505001508.255096-1-linux@treblig.org>
 <20240506070648.GA6506@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240506070648.GA6506@lst.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:11:41 up 12 days,  2:25,  1 user,  load average: 0.07, 0.04, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Christoph Hellwig (hch@lst.de) wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph; any ideas who might take this?

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

