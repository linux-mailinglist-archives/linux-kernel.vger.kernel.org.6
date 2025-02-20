Return-Path: <linux-kernel+bounces-524065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA56A3DECA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39617AD8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD621E9B12;
	Thu, 20 Feb 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LXDuCBOw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YADQiCNc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LXDuCBOw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YADQiCNc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E521FFC78
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065397; cv=none; b=HhLb/VCf7gKPQ94edQ+eX8sveg1JnMhvkU7GbuYTFJi/7tuCZ/Lt99PDgReSK6lWejo3QQdjIotXnkIS2//kF3S7eLeFX1dVwQBu1w0m9lXqZhcwXoSL9JMpxplyagqoKAyXXx/ZiX+LGdsTbCnJ5uu1AFrAVo2IlBUQSFFOtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065397; c=relaxed/simple;
	bh=aM+odtDBrmWA9iDXbZQjn7jaxdEI23bVhQD5HhLw4aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGRkyZU9mQkX67MX4TMgCJyFtjZE7DpdAcIKGkkNWoWT1Rl6f+xpLTcXB2utwOP+Ky7zWJiHnnY8545VhkRNg+IUm+DafKITLg9jgnfgNVySM7FgdlsdGypZbCFu6q2WG2gBvl+yy0kcYQadIrEECARA2M+rlHyWA6dc1L+2Mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LXDuCBOw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YADQiCNc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LXDuCBOw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YADQiCNc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C976A1F388;
	Thu, 20 Feb 2025 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740065391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb/RiXD5g13iqlSAPF/HYk9tHqQ8XfmsjURlIeRYP/Q=;
	b=LXDuCBOwLJdOU9mRDC8iZyUj4WjiNAYn0c7Ns1bnPyI6/2I+8XU7iuidBMvNd3xgXc6Y/a
	rcozu9trtwVN1pPTmo/BWRP9yxOEdK4kTISj6+VOFyjWCjQ9UGKm/S5F48p59xSty9oRke
	oGc5iMCeF4skiF17wt1dIVk8DqjztWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740065391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb/RiXD5g13iqlSAPF/HYk9tHqQ8XfmsjURlIeRYP/Q=;
	b=YADQiCNc2q6Bb7vt9PEO8WgpwL4fzRBf1RbCsPMM1EDvMgo7UQWJv9Gs+HU26YTA4zKkA9
	bstIXxngQXRAO7Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LXDuCBOw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YADQiCNc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740065391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb/RiXD5g13iqlSAPF/HYk9tHqQ8XfmsjURlIeRYP/Q=;
	b=LXDuCBOwLJdOU9mRDC8iZyUj4WjiNAYn0c7Ns1bnPyI6/2I+8XU7iuidBMvNd3xgXc6Y/a
	rcozu9trtwVN1pPTmo/BWRP9yxOEdK4kTISj6+VOFyjWCjQ9UGKm/S5F48p59xSty9oRke
	oGc5iMCeF4skiF17wt1dIVk8DqjztWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740065391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb/RiXD5g13iqlSAPF/HYk9tHqQ8XfmsjURlIeRYP/Q=;
	b=YADQiCNc2q6Bb7vt9PEO8WgpwL4fzRBf1RbCsPMM1EDvMgo7UQWJv9Gs+HU26YTA4zKkA9
	bstIXxngQXRAO7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A240213A42;
	Thu, 20 Feb 2025 15:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6hJJ29Kt2ficAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 20 Feb 2025 15:29:51 +0000
Message-ID: <fc94c383-5788-43c8-beb3-2fd76acae7bd@suse.cz>
Date: Thu, 20 Feb 2025 16:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Byungchul Park <byungchul@sk.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, david@redhat.com, peterz@infradead.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20250220052027.58847-1-byungchul@sk.com>
 <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8accbd91-ca59-43f8-b190-7e1ac3df5e11@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C976A1F388
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[skhynix.com,linux-foundation.org,intel.com,tencent.com,techsingularity.net,google.com,infradead.org,redhat.com,kernel.org,linutronix.de,alien8.de,linux.intel.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/20/25 16:15, Dave Hansen wrote:
> On 2/19/25 21:20, Byungchul Park wrote:
>> I'm posting the latest version so that anyone can try luf mechanism if
>> wanted by any chance.  However, I tagged RFC again because there are
>> still issues that should be resolved to merge to mainline:
> 
> I don't see anything fundamentally different here from the last 11
> versions. I think the entire approach is dangerous and basically makes
> things impossible to debug. It's not clear that some of the failure
> scenarios that I've brought up in the past have actually been fixed.

Yes, and it's still an invasive change to the buddy allocator.
IIRC at Plumbers the opinion in the audience was that there might be ways to
improve the batching on unmap to reduce the flushes without such an invasive
and potentially dangerous change? Has that been investigated?

Also "Rebase on akpm/mm.git mm-unstable(5a7056135b) as of Nov 22, 2024." is
very outdated at this point?

Thanks,
Vlastimil

> What I've said here still stands:
> 
>> https://lore.kernel.org/all/fab1dd64-c652-4160-93b4-7b483a8874da@intel.com/
> 
>> I think tglx would call all of this "tinkering".  The approach to this
>> series is to "fix" narrow, specific cases that reviewers point out, make
>> it compile, then send it out again, hoping someone will apply it.
>> 
>> So, for me, until the approach to this series changes: NAK, for x86.
>> Andrew, please don't take this series.  Or, if you do, please drop the
>> patch enabling it on x86.
> 
> I think I'd also like to stop being cc'd on this. If LUF is merged into
> mainline and proven to work on arm64 or riscv for a year, I'd be happy
> to take another look at enabling it on x86. I think that's just about
> the only thing that would make me reconsider.
> 


