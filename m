Return-Path: <linux-kernel+bounces-242506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C740C92890A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBAE1F24559
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9314A4C0;
	Fri,  5 Jul 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="aKWmIexE"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4914A611;
	Fri,  5 Jul 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183939; cv=none; b=CXG9f47JPHOZWopZY6tMbGShPwpYuiOoIN4yWP+buRJTvwEij81DFfQaaasO0wkO/ykbxNI8mbrnkIogM9bkVPN6ZlsNwYlO8uRgzI8uxz2INDciYfw0TGwApON3zYciNL2JtVoV78pOEgcP2OoNPs5xVc+uXQBYg7VlwDmRjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183939; c=relaxed/simple;
	bh=7kBlWX5IEjt76uHtdjl0JfbnGpCYIXt9+Cd5iPfrNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIuK7V8x6aoglkRK62wopxL/d3dImGNCzfTIs5AA9R3qdnq828lUosNuJTkcIl/wLY7LCnaEA5gKexC+aNhQuC2lKykv0QCs/JdVOsA6stYx1CNWwe8o1hJwdr5MqmUMcACN89Cho5I3xko+GAeeA5upL7mnkxfqI9D0Vz6Z5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=aKWmIexE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=aqopr3TWiXyLLHh0M88tvYFmQ9Q3ye+UGysR6XfsiKc=; b=aKWmIexEWBsczvVA
	+NDFFj0tI8zU2UkeLSEwvmBxrjmq/sGQuRAb/Y3pPsJT1AeEs0NM2i0v8dqLTqaTdKXWzWVg7fpt/
	69fa9UqcqR7ZYXZLMc12wcFhh5ihMhw9thiWq9pVEWzA35V19NizRZTyNKtUtfWt5hoN3PmyLc5KW
	GH9Y7+gVyxZkC1aehbSAPL/dCQ/UrjLXrltgPvKu/jFApzd9Y8uYGV2vnTBgVfOxUwAK5P6ziHa3p
	/0cwXi4QWP4R5lCVNFng3+h13whnAn9LjR4Tkhvd8nW9Zmfo9wMV4PoCvi22hIkg8v2fMgM2QLzha
	m95okxBCJOMCJ+eSWQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sPiQA-00ACVr-3C;
	Fri, 05 Jul 2024 12:52:14 +0000
Date: Fri, 5 Jul 2024 12:52:14 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: spcp8x5: remove unused struct
 'spcp8x5_usb_ctrl_arg'
Message-ID: <Zofsfme4wSK3gKrb@gallifrey>
References: <20240529234722.130609-1-linux@treblig.org>
 <ZofSj98X-uEr-Awj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZofSj98X-uEr-Awj@hovoldconsulting.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:52:05 up 58 days, 6 min,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Johan Hovold (johan@kernel.org) wrote:
> On Thu, May 30, 2024 at 12:47:22AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'spcp8x5_usb_ctrl_arg' has been unused since the original
> > commit 619a6f1d1423 ("USB: add usb-serial spcp8x5 driver").
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Now applied, thanks.

Thanks!

Dave

> Johan
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

