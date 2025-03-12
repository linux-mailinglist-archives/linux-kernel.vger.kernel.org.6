Return-Path: <linux-kernel+bounces-558550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A92A5E77A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBEE17D545
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAE1EF397;
	Wed, 12 Mar 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pUS2Z/eU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30871DFD95;
	Wed, 12 Mar 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818645; cv=none; b=U31hUDmemfZLZdyPilKG8bc+WGi1lUur1aWKrzZMDmRHj0WEn0G2dVQVJ1ImpLEjd4nD0mvIYDqlhN29jFuQL0txhOrl1uhanOiL6DLCTEKP0mF/Tiw83FwqoJ2jxJeIo6wcmfhv01f5EKvaethugBpn9AKNkZWSRd+qFmp+ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818645; c=relaxed/simple;
	bh=/5u4xWileZI4BqZZkjltZzTrP6QsO0Oq0cGDX0v38VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCc+QGewCie8IK2cFMKr3KCLJ47teT4qwAysAJYwYf9RVlIMVbf4GuooobdITsxmfJuKDpVBAr/ufyFxzd3D1Qx4EhPQd5jXXfvLYf8bDhJVG9BYOYBiG2ePLqV4xyylH1onuIaWgFbXnTqP51frCAt/IhDmQSb6wbk7cCYVn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pUS2Z/eU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D62B441063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741818643; bh=WmyI+FyclJmL6XgBE5kwSw0ma2aJx2vXptVQysOPWrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pUS2Z/eUsxgFSdn37S63JrojfPFKzjylkhN0jyn6yfpW8w9j7+vmNBycbnFPCPNd1
	 blX/cgDECRyrWXkwm0WCk2CmqrnjLDD8GJIrWpT5viJ1RUr2TFmZvZgzyrUrH+FVOH
	 zt9IlrID2mmdfQBXnlXB+K4aRmeCnPaCIDNkm4sApCPZcDRtFc6zYWGqHpb673SouU
	 xqTSQ2WlByD6f6RsnUf6i4wpLkgADUiVyUNTXv7hGrVr6/UvUTD5fUQHUrNH9VNBzJ
	 dsNiTqcT5qxVSeIZyvsxEYj+drorkcMjGZPPoesez7Cb3ggPMN+MWvJw+5+Y+2BODz
	 XvlqI9yV2V5Ng==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D62B441063;
	Wed, 12 Mar 2025 22:30:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Wilcox <willy@infradead.org>, kth <kangtaeho2456@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix typo from smpfs to smbfs in filesystem
 documentation
In-Reply-To: <Z889RfnudqMc5r_e@casper.infradead.org>
References: <20250310184129.328482-1-kangtaeho2456@gmail.com>
 <Z889RfnudqMc5r_e@casper.infradead.org>
Date: Wed, 12 Mar 2025 16:30:42 -0600
Message-ID: <87wmctlw4t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Mar 11, 2025 at 02:41:29AM +0800, kth wrote:
>> The documentation incorrectly referred to 'smbfs' as 'smpfs'. This change corrects that typo to ensure the documentation is accurate and not misleading.
>> 
>> Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
>> ---
>>  Documentation/admin-guide/highuid.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
>> index 6ee70465c0ea..9239067563a1 100644
>> --- a/Documentation/admin-guide/highuid.rst
>> +++ b/Documentation/admin-guide/highuid.rst
>> @@ -64,7 +64,7 @@ What's left to be done for 32-bit UIDs on all Linux architectures:
>>  
>>    Other filesystems have not been checked yet.
>>  
>> -- The ncpfs and smpfs filesystems cannot presently use 32-bit UIDs in
>> +- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in
>
> ncpfs doesn't exist any more; it was removed many years ago.  And the
> smbfs that is referred to here was replaced by cifs many years ago.
>
> I have a feeling the entire highuid document should be deleted.  It
> describes a transition that happened 25 years ago.

That seems like the right thing to do - it's essentially somebody's
"todo" list from 2000, which lacks relevance now.

Kang, would you like to submit a patch to simply remove the file
instead?

Thanks,

jon

