Return-Path: <linux-kernel+bounces-409262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6309C89AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D628363C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1131FA240;
	Thu, 14 Nov 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TA/12yrs"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FB1F9EA0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586678; cv=none; b=UAjjjmhJ3bHRg0L6ffOdS6o8617fhXiXmnkEAe5liGqRJFmt1rhIM2YGUYmV+H5pHOkjTJocnRKqlAUID2ztG3IVWUldlE8QdsYj/T7XOk07MAy9cRUqI+1w9kvZ9l5iStEghYW+o0s96lk0JeCwPxv9uFqk69Gb/JMTt18/cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586678; c=relaxed/simple;
	bh=AbUAkpWgrLbt/fQv9TcPNAvJyplZoel79AmU9f8amUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsSuA5Tb+dNU+lAdvvT1mghR56JYEBm0+8/wuCJIRnV9nYwDKDJ1ic2Wc6tih9ln59nAc9OfgQ+fp7KPL9Emj2GYgejtTPWfHe+UeLa1MSojEOjG1SjiXfVlHg90pkjCZ218Oo+w81A+uP9ANSScmDZS1JZ7Z3JGHyA05Fll8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TA/12yrs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=DzdVV4+miMA35zeFgd+sgJyQCfWLc7YGKu3HAdx8HQI=; b=TA/12yrsvhpqrOxs
	ZnHRhnvy1eYwHu109cwK0wj87rkGfsb+RcPnCYPLzhVGHsCpIi6ewchaBxgjjCTRGFn2pWQc6oPIm
	xyppzXFNMkQ33GUrC/iFgHCmwyxPvWG5Z2gvQmsEPsXrmH4tG6zTdB1ruJ+4SFDQVRXkdqCeK0umr
	gepQbcj8i42XHA07SRA4fvxW+9upYB/rXu4vMpKj7WJLumk/MG8XQTapnTyEgts+OXZBkyKrnqKc7
	uunnYNFZKodNrUm81rNxsjC7pDDiqFCURaCugo5Xj9TpfJivIUb9JGB3DtRNM+RLLPFb9tLp/2FYi
	0atKYGebFgnDpaM+Lg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tBYnH-00HVQk-0q;
	Thu, 14 Nov 2024 12:17:51 +0000
Date: Thu, 14 Nov 2024 12:17:51 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@lst.de>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: Remove unused configfs_hash_and_remove
Message-ID: <ZzXqb417yZq23wj7@gallifrey>
References: <20241010205655.278385-1-linux@treblig.org>
 <ZzPKbY3n9gxHebJl@gallifrey>
 <20241114053147.GA10563@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114053147.GA10563@lst.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:17:40 up 189 days, 23:31,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Christoph Hellwig (hch@lst.de) wrote:
> Hi David,
> 
> I thought I already picked this up, but I didn't.
> 
> It is queued up now, thanks a lot!

Thanks!

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

