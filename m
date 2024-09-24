Return-Path: <linux-kernel+bounces-337553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B654984B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9BE1C230AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6857136328;
	Tue, 24 Sep 2024 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZBGDP9p"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962440BF2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206414; cv=none; b=VKTKRTrNMAf0b6YnYznU8+7rMInDY9bDNAP5xQz1MiZTGq6ivUrTzPo/b/3yC0JciDTpAPhjfrOy6Hi0YBFHU/sw1tgGMUAkTu5LclGZUfI1Cli3Rz+UnS3V9iD2ahUQqpxYDgkXKhJhLfR+K9ZpKos4dHCW6rEU3SMaakGo4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206414; c=relaxed/simple;
	bh=xYIluz4MQgZnS0PvbaO7h7TVpf/Zheu9pqJDwzbG2lc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aTlwnBwn/gc4jOHH07R/0tT6E5hNvqkJx+i0Mtw6hjfN3lXZ/+oiDN8J6CRzv4HmynjQn0xGi97pq3oA8ZBlW2ijWrekmVRlyu35hGB8zEh39C4qKTWzl4OU/PekGM4whrkq33POhwYYPBu9Fu3IldwZP5PgQrtMwJeAWdHJexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZBGDP9p; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727206408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLR6bhEI1FdlD20fqnApTL+T+S9SCIn4Pwas1mbHVQo=;
	b=MZBGDP9pEt+xC4TsJzKgcT4vLyrQJYv8odCUfWhib8pYAIJFMVQBP+mcbAebUAYEslzBu8
	5+xMOYydPsgzjil3RJQ9iG3+opMgUvtkmjS2C5sOe+81vYdc3okYo6V0JLWoVCf0lRehYv
	iVWSzuUo8PNbBg6Uo5isCGJCkjlcOIk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] ksmbd: Annotate struct copychunk_ioctl_req with
 __counted_by_le()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d6341fc4-1d9d-46af-b809-f30430b30455@talpey.com>
Date: Tue, 24 Sep 2024 21:33:15 +0200
Cc: Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C22D945F-4C40-4C0E-8074-07747C944C99@linux.dev>
References: <20240924102243.239811-2-thorsten.blum@linux.dev>
 <d6341fc4-1d9d-46af-b809-f30430b30455@talpey.com>
To: Tom Talpey <tom@talpey.com>
X-Migadu-Flow: FLOW_OUT

Hi Tom,

> On 24. Sep 2024, at 20:05, Tom Talpey <tom@talpey.com> wrote:
> On 9/24/2024 6:22 AM, Thorsten Blum wrote:
>> Add the __counted_by_le compiler attribute to the flexible array =
member
>> Chunks to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> Read Chunks[0] after checking that ChunkCount is not 0.
>> Compile-tested only.
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  fs/smb/server/smb2pdu.c | 2 +-
>>  fs/smb/server/smb2pdu.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
>> index 461c4fc682ac..0670bdf3e167 100644
>> --- a/fs/smb/server/smb2pdu.c
>> +++ b/fs/smb/server/smb2pdu.c
>> @@ -7565,7 +7565,6 @@ static int fsctl_copychunk(struct ksmbd_work =
*work,
>>   ci_rsp->TotalBytesWritten =3D
>>   cpu_to_le32(ksmbd_server_side_copy_max_total_size());
>>  - chunks =3D (struct srv_copychunk *)&ci_req->Chunks[0];
>>   chunk_count =3D le32_to_cpu(ci_req->ChunkCount);
>>   if (chunk_count =3D=3D 0)
>>   goto out;
>> @@ -7579,6 +7578,7 @@ static int fsctl_copychunk(struct ksmbd_work =
*work,
>>   return -EINVAL;
>>   }
>>  + chunks =3D (struct srv_copychunk *)&ci_req->Chunks[0];
>>   for (i =3D 0; i < chunk_count; i++) {
>>   if (le32_to_cpu(chunks[i].Length) =3D=3D 0 ||
>>      le32_to_cpu(chunks[i].Length) > =
ksmbd_server_side_copy_max_chunk_size())
>> diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
>> index 73aff20e22d0..f01121dbf358 100644
>> --- a/fs/smb/server/smb2pdu.h
>> +++ b/fs/smb/server/smb2pdu.h
>> @@ -194,7 +194,7 @@ struct copychunk_ioctl_req {
>>   __le64 ResumeKey[3];
>>   __le32 ChunkCount;
>>   __le32 Reserved;
>> - __u8 Chunks[]; /* array of srv_copychunk */
>> + __u8 Chunks[] __counted_by_le(ChunkCount); /* array of =
srv_copychunk */
>>  } __packed;
>> =20
>=20
> This isn't correct. The u8 is just a raw buffer, copychunk structs are
> marshaled into it, and they're 24 bytes each.

Hm, I see.

How does this for-loop work then? It iterates over ci_req->ChunkCount
and expects a srv_copychunk at each ci_req->Chunks[i]?

for (i =3D 0; i < chunk_count; i++) {
	if (le32_to_cpu(chunks[i].Length) =3D=3D 0 ||
	    le32_to_cpu(chunks[i].Length) > =
ksmbd_server_side_copy_max_chunk_size())
		break;
	total_size_written +=3D le32_to_cpu(chunks[i].Length);
}

Thanks,
Thorsten=

