Return-Path: <linux-kernel+bounces-215176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5820908F65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8862AB2F819
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED816B754;
	Fri, 14 Jun 2024 15:41:35 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD1922ED;
	Fri, 14 Jun 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379694; cv=none; b=UpVKhVYxSi5zgTuRp1fDC6Goj8AgymUP35iYCafJeIQz/b/IKLG7lPvhhvon4tVKGladvNhx2oJjtFG6C19GeHVVbewML3pLNf8Vwwe8E7HCjRsH0P0PALGD/kY5pnYaDrU7oBGZiNuyCIF6L3f7Hy1eL4Eq61eUYVKdPIDLhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379694; c=relaxed/simple;
	bh=NuypO2a4UCFR+QKwfwKznr+i/G+Uu16jAhZA/QVOWRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQxNI+tuV7NWu8buarTCW/eIBLoiJMaP7cyJ3bGN5+cFwdwVQC45MK5NneGq9jx2QbISttMefV9g3SLngrpXW6SVZKGFruPTn6hlK1lroNKzO09yrBGd1hlyxWUjw382itS4X8YhGOqYQEQRoxDVNRWodpdiNHApg+4vRbgXV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz14t1718379665tmshyc
X-QQ-Originating-IP: hsNr8Dbi+rmVRMwgNwSA6NX71qYffL9sTWsd1BX6hZ0=
Received: from [172.16.211.131] ( [220.202.230.232])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Jun 2024 23:41:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4420144836948564987
Message-ID: <4BA53556BED3049F+15d632a4-567a-4350-b4a3-c4ba77721fa5@chenxiaosong.com>
Date: Fri, 14 Jun 2024 23:40:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about pNFS documentation
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Olga Kornievskaia <kolga@netapp.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>, neilb@suse.de, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
 "huhai@kylinos.cn" <huhai@kylinos.cn>,
 "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>
References: <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
 <08BB98A6-FA14-4551-B977-8BC4029DB0E1@oracle.com>
 <93D6D58053EB522F+de1c8896-65e1-442d-99f6-c5b222c0a816@chenxiaosong.com>
 <1D4505F5-1923-4E7B-A12B-F1E05308914C@oracle.com>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <1D4505F5-1923-4E7B-A12B-F1E05308914C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Thanks very much for your detailed reply.

在 2024/6/14 21:00, Chuck Lever III 写道:
> 
>> On Jun 14, 2024, at 4:37 AM, ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:
>>
>> Thanks for your reply. By the way, are there any plans for the Linux NFS server to implement the file, flexfile and object layout?
> 
> The object layout type has been deprecated, IIRC. Support for
> that type was removed from the Linux NFS client years ago. No
> support for it in the server is planned.
> 
> The file layout type generally needs a cluster file system
> on the back end. You could build something over Ceph or
> gfs2, but it would be a significant effort and would need
> user demand. Currently there isn't any.
> 
> The NFS server has a toy flexfile layout implementation
> which is not much more than a proof of concept. We do have
> an unscoped to-do to look at building that out to provide
> a platform for testing the client's flexfile support. That
> effort is not a high priority.
> 
> 
> --
> Chuck Lever
> 
> 

