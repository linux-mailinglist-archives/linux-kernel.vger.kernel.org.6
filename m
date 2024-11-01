Return-Path: <linux-kernel+bounces-392124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EFA9B8FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E39B20F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120C185E53;
	Fri,  1 Nov 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0y+O3Fca";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEQtQayC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02314F126
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459297; cv=none; b=Y8LTk9+o5iiFTk2uTZ2jvLGXnuzFdZnBlWv1QyqlhRYaFFt5wgGpISrzc6fHz4m+pJBw6VfnJ3J7mD1CvAwGYwCiRF/DA5Uk1kryjaumfbQwq0yz0VeQn1DeqEFb/vdrd3jjGuYye8hihISYWRc6TS3qQ34YPeKK3CY79lcgIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459297; c=relaxed/simple;
	bh=YzDUAQ4Kbr4gt4palOjTdwRuSi1ad7Wx0FHyDzLKiFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRdQPEtpISfxTSdakULIffcWTogPEMyUxZdZkuFixkibzUz3HllxBsPWqJ175vyAMjsQboF4ClNDc1wUgNirEsAmbaxig5sxBRnqVKlDueMBqALKUy1XAVkBB9DpWEB82FwXAAX0PXyRifVq/9pYGBkqI4+sxygnqexP9tXZ/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0y+O3Fca; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEQtQayC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 1 Nov 2024 12:08:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730459292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzZSJORFNPYNMV1lqmBPi4591uMGW3qTHNmE3M+RQow=;
	b=0y+O3FcafdBDVjp6rvH/CpQclmuotzaY0v+MdZSWdwRQLWe1vkj+VoYJrAjSvRt2Mdatoy
	se/qk3fBqw5iajftj6wI2IQ+jedUSEuSb4HcRH/YoH046fiv2P7eU3LHOrkyNb1bBKSkqn
	rONxgJiskCSchAELrdVS7ex+OU8una61+ovh2ZlImRtu15QZCakdBF26ynb6lGtFI+YSz8
	pAlkvsxQ+3GDd6k7/JObNH5EKpYrYZpmjlNfBDGmPE2i69Tanxhpv8hFEnIzcUUN0eN7GM
	YkV7RUjsfrwwl9oTRHMyomkjtVaWXpKGQcVqy5wQwnvOjTMny4Bdf6HU8OxXcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730459292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzZSJORFNPYNMV1lqmBPi4591uMGW3qTHNmE3M+RQow=;
	b=wEQtQayColHWXDeWshKHwFLV7ck5FHLvaOk7k7fl6NPfI8Q00kWfM4LRednxRBKG6YxOnc
	vz5y/z1eBxqMcTDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <20241101110810.R3AnEqdu@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
 <20241031155640.Fhtm3uFD@linutronix.de>
 <20241031174736.apc_hFru@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031174736.apc_hFru@linutronix.de>

On 2024-10-31 18:47:40 [+0100], To linux-kernel@vger.kernel.org wrote:
> On 2024-10-31 16:56:43 [+0100], To linux-kernel@vger.kernel.org wrote:

Since all of this can be scripted and I can have one kernel with =E2=80=A6
so I hooked various hash algorithms to see where we get to.
240 threads, same box.
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
| buckets | jhash2 (regular) | jhash2 (addr+offs) |      xxhash |   hash_lo=
ng |      crc32c |       crc32 |     siphash |    hsiphash |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
|       2 |          9,172.4 |            9,175.8 |     9,116.4 |     9,497=
=2E2 |     9,317.6 |     9,564.0 |     9,091.8 |     9,217.8 |
|       4 |         23,370.8 |           22,611.0 |    20,917.2 |    17,780=
=2E6 |    18,185.6 |    17,305.4 |    20,415.0 |    20,885.4 |
|       8 |         44,378.2 |           44,898.4 |    44,713.8 |    42,943=
=2E8 |    45,151.8 |    45,149.6 |    44,601.4 |    44,739.4 |
|      16 |         84,567.2 |           84,190.0 |    84,645.2 |    84,737=
=2E4 |    86,970.2 |    85,036.8 |    83,142.0 |    85,485.0 |
|      32 |        131,059.2 |          127,895.4 |   127,953.8 |   126,631=
=2E2 |   132,293.0 |   125,622.2 |   127,038.4 |   126,322.8 |
|      64 |        285,339.0 |          284,488.8 |   288,109.2 |   268,630=
=2E4 |   289,783.8 |   285,281.0 |   285,111.2 |   288,104.4 |
|     128 |        510,550.0 |          515,596.6 |   526,738.0 |   557,349=
=2E6 |   508,871.6 |   524,447.0 |   512,482.8 |   513,963.0 |
|     256 |      1,038,348.6 |        1,034,837.4 | 1,042,341.4 | 1,060,650=
=2E4 | 1,039,328.6 | 1,098,865.8 | 1,042,759.4 | 1,026,998.6 |
|     512 |      1,626,287.8 |        1,640,112.0 | 1,622,828.8 | 1,637,973=
=2E4 | 1,677,108.6 | 1,707,027.2 | 1,588,240.6 | 1,628,800.8 |
|    1024 |      1,827,878.6 |        1,849,074.4 | 1,836,483.8 | 1,776,366=
=2E4 | 1,884,670.8 | 1,842,734.2 | 1,765,815.0 | 1,822,137.8 |
|    2048 |      1,905,406.4 |        1,928,399.2 | 1,903,506.0 | 1,822,750=
=2E8 | 1,946,141.6 | 1,907,584.6 | 1,830,906.8 | 1,887,678.2 |
|    4096 |      1,912,522.6 |        1,929,667.4 | 1,907,121.6 | 1,847,231=
=2E6 | 1,949,908.0 | 1,927,728.6 | 1,834,648.0 | 1,893,792.2 |
|    8192 |      1,912,352.6 |        1,935,078.4 | 1,915,500.4 | 1,853,232=
=2E2 | 1,973,339.2 | 1,958,150.4 | 1,840,190.8 | 1,896,981.6 |
|   16384 |      1,917,836.8 |        1,941,917.0 | 1,910,106.0 | 1,863,751=
=2E4 | 1,955,101.4 | 1,947,673.2 | 1,836,488.2 | 1,898,002.0 |
|   32768 |      1,919,074.6 |        1,937,200.2 | 1,914,704.8 | 1,872,348=
=2E0 | 1,974,182.2 | 1,959,147.2 | 1,837,694.6 | 1,896,566.6 |
|   65536 |      1,930,988.0 |        1,959,076.0 | 1,926,927.6 | 1,873,267=
=2E6 | 1,914,420.8 | 1,951,292.4 | 1,849,658.6 | 1,910,334.6 |
|  131072 |      2,023,509.4 |        2,050,380.4 | 2,037,104.6 | 1,990,559=
=2E6 | 2,003,758.4 | 1,978,931.2 | 1,946,145.2 | 2,007,205.6 |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+

Intel(R) Xeon(R) CPU E7-8890 v3, 144 CPUs, 4 nodes.
Test using 140 threads, 0 buckets means global hash:
+---------+-------------+
| buckets |     ops/sec |
+---------+-------------+
|       0 | 2,644,742.8 |
|       2 |    21,750.2 |
|       4 |    37,537.2 |
|       8 |    69,950.6 |
|      16 |   127,722.0 |
|      32 |   225,479.2 |
|      64 |   401,335.6 |
|     128 |   753,714.8 |
|     256 | 1,376,116.0 |
|     512 | 2,008,764.2 |
|    1024 | 2,386,441.2 |
|    2048 | 2,564,764.0 |
|    4096 | 2,851,801.2 |
|    8192 | 2,862,999.6 |
|   16384 | 2,521,325.0 |
|   32768 | 2,421,839.2 |
|   65536 | 2,483,676.0 |
|  131072 | 2,733,504.2 |
+---------+-------------+

Binding the test to individual NUMA node, 34 threads:
+---------+-------------+-------------+-------------+-------------+
| buckets |      node 0 |      node 1 |      node 2 |      node 3 |
+---------+-------------+-------------+-------------+-------------+
|       0 | 4,149,878.4 | 4,149,079.8 | 4,148,085.2 | 4,149,420.6 |
|       2 |   194,714.4 |   197,382.8 |   191,967.0 |   193,510.6 |
|       4 |   363,778.6 |   360,700.2 |   364,293.6 |   361,830.2 |
|       8 |   681,770.4 |   673,973.0 |   658,601.6 |   662,212.0 |
|      16 | 1,201,256.4 | 1,177,681.0 | 1,195,749.4 | 1,181,200.2 |
|      32 | 2,002,673.2 | 1,989,139.0 | 1,988,264.4 | 1,981,004.8 |
|      64 | 2,963,416.0 | 2,962,292.0 | 2,957,491.6 | 2,964,479.6 |
|     128 | 3,499,580.0 | 3,495,971.2 | 3,495,537.6 | 3,499,902.8 |
|     256 | 3,713,251.2 | 3,711,806.4 | 3,716,935.4 | 3,715,458.2 |
|     512 | 3,800,606.4 | 3,801,960.4 | 3,813,903.4 | 3,809,076.6 |
|    1024 | 3,840,679.0 | 3,839,486.4 | 3,841,558.6 | 3,838,641.4 |
|    2048 | 3,867,732.8 | 3,866,216.2 | 3,858,603.4 | 3,848,031.6 |
|    4096 | 3,806,776.8 | 3,819,237.8 | 3,813,381.4 | 3,800,440.2 |
|    8192 | 3,815,358.4 | 3,806,204.2 | 3,804,171.2 | 3,795,476.2 |
|   16384 | 3,865,728.6 | 3,883,038.4 | 3,871,992.0 | 3,857,763.4 |
|   32768 | 4,017,227.0 | 4,025,249.8 | 4,022,779.4 | 4,009,740.8 |
|   65536 | 4,188,410.0 | 4,186,900.8 | 4,195,128.4 | 4,190,580.8 |
|  131072 | 4,334,937.0 | 4,335,978.8 | 4,327,250.2 | 4,332,567.8 |
+---------+-------------+-------------+-------------+-------------+

140 threads, all nodes for the algorithms test:
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
| buckets | jhash2 (regular) | jhash2 (addr+offs) |      xxhash |   hash_lo=
ng |      crc32c |       crc32 |     siphash |    hsiphash |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
|       2 |         21,346.0 |           21,321.8 |    20,598.4 |    23,403=
=2E0 |    23,336.6 |    21,232.8 |    21,011.4 |    20,661.0 |
|       4 |         38,220.0 |           37,712.0 |    37,421.6 |    39,206=
=2E4 |    39,086.2 |    40,098.2 |    37,144.2 |    37,209.8 |
|       8 |         68,470.8 |           68,994.4 |    69,373.6 |    73,973=
=2E0 |    70,306.8 |    70,396.0 |    68,950.8 |    69,366.6 |
|      16 |        126,612.2 |          127,433.2 |   128,121.2 |   133,981=
=2E8 |   127,268.0 |   130,204.4 |   126,594.4 |   127,812.8 |
|      32 |        224,943.0 |          224,695.2 |   222,879.6 |   227,023=
=2E8 |   220,036.4 |   217,311.2 |   224,100.0 |   223,442.8 |
|      64 |        406,235.6 |          399,020.2 |   407,580.6 |   413,988=
=2E6 |   404,817.4 |   394,156.0 |   411,282.8 |   389,992.6 |
|     128 |        758,259.0 |          759,423.2 |   755,778.8 |   774,913=
=2E8 |   765,497.8 |   763,987.8 |   748,676.8 |   749,303.6 |
|     256 |      1,381,720.6 |        1,380,707.6 | 1,372,685.0 | 1,357,849=
=2E0 | 1,331,275.2 | 1,430,867.4 | 1,377,411.6 | 1,374,432.2 |
|     512 |      2,001,912.4 |        2,011,120.8 | 1,993,617.8 | 2,331,041=
=2E0 | 2,097,737.0 | 2,079,965.6 | 1,971,513.8 | 1,989,508.6 |
|    1024 |      2,378,279.6 |        2,412,139.6 | 2,371,655.4 | 2,650,416=
=2E8 | 2,477,507.8 | 2,456,023.8 | 2,309,010.4 | 2,353,854.2 |
|    2048 |      2,560,923.0 |        2,604,756.2 | 2,544,586.6 | 2,658,535=
=2E8 | 2,631,261.0 | 2,628,532.0 | 2,459,461.2 | 2,523,348.0 |
|    4096 |      2,855,199.2 |        2,942,364.8 | 2,822,369.8 | 2,998,159=
=2E4 | 2,936,124.2 | 2,919,140.6 | 2,694,488.8 | 2,794,201.4 |
|    8192 |      2,868,792.8 |        2,953,256.8 | 2,834,506.0 | 2,993,257=
=2E8 | 2,924,754.2 | 2,941,119.0 | 2,705,526.4 | 2,806,921.2 |
|   16384 |      2,527,784.0 |        2,595,100.2 | 2,498,789.8 | 2,610,646=
=2E8 | 2,540,535.4 | 2,550,376.0 | 2,398,098.4 | 2,475,184.4 |
|   32768 |      2,427,199.8 |        2,492,474.2 | 2,408,768.4 | 2,486,733=
=2E6 | 2,381,828.0 | 2,425,293.0 | 2,312,774.0 | 2,384,687.6 |
|   65536 |      2,489,441.8 |        2,554,741.4 | 2,465,692.0 | 2,666,031=
=2E8 | 2,419,651.8 | 2,515,099.8 | 2,368,451.8 | 2,438,185.6 |
|  131072 |      2,745,458.4 |        2,820,823.0 | 2,720,660.6 | 3,282,233=
=2E0 | 2,625,217.6 | 2,466,424.0 | 2,597,005.2 | 2,680,356.4 |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+

And now something smaller, Intel(R) Xeon(R) CPU E5-2650 0, 32CPUs in
total.
28 threads used for the test:
+---------+-------------+
| buckets |     ops/sec |
+---------+-------------+
|       0 | 2,344,905.8 |
|       2 |    91,881.2 |
|       4 |   168,243.0 |
|       8 |   310,982.2 |
|      16 |   550,534.4 |
|      32 |   884,066.0 |
|      64 | 1,475,389.4 |
|     128 | 1,949,364.6 |
|     256 | 2,142,025.8 |
|     512 | 2,234,222.2 |
|    1024 | 2,267,931.8 |
|    2048 | 2,287,753.4 |
|    4096 | 2,315,330.4 |
|    8192 | 2,337,878.2 |
|   16384 | 2,444,502.2 |
+---------+-------------+

14 Threads limited to a node:
+---------+-------------+-------------+
| buckets |      node 0 |      node 1 |
+---------+-------------+-------------+
|       0 | 2,761,709.8 | 2,765,630.0 |
|       2 |   397,527.8 |   397,126.8 |
|       4 |   718,205.0 |   719,615.2 |
|       8 | 1,350,627.4 | 1,305,201.4 |
|      16 | 1,992,643.4 | 1,989,499.2 |
|      32 | 2,365,813.6 | 2,357,618.6 |
|      64 | 2,554,185.8 | 2,555,256.8 |
|     128 | 2,646,479.0 | 2,654,572.6 |
|     256 | 2,679,394.4 | 2,698,002.4 |
|     512 | 2,713,385.6 | 2,723,413.6 |
|    1024 | 2,719,330.6 | 2,733,464.6 |
|    2048 | 2,730,376.6 | 2,738,581.6 |
|    4096 | 2,704,520.6 | 2,720,546.4 |
|    8192 | 2,773,213.4 | 2,782,565.6 |
|   16384 | 2,863,843.2 | 2,858,963.2 |
+---------+-------------+-------------+

And now algorithms, 28 Threads.
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
| buckets | jhash2 (regular) | jhash2 (addr+offs) |      xxhash |   hash_lo=
ng |      crc32c |       crc32 |     siphash |    hsiphash |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+
|       2 |         92,557.8 |           92,815.2 |    93,172.2 |   103,097=
=2E6 |    97,403.2 |    92,629.6 |    94,030.8 |    91,847.2 |
|       4 |        165,385.2 |          167,200.0 |   168,681.2 |   177,600=
=2E2 |   172,851.2 |   173,423.6 |   167,814.6 |   168,136.8 |
|       8 |        319,044.0 |          317,291.6 |   318,322.0 |   342,179=
=2E4 |   318,252.6 |   323,456.6 |   319,079.6 |   317,106.2 |
|      16 |        555,103.6 |          556,075.0 |   563,529.0 |   595,052=
=2E8 |   537,199.2 |   557,180.4 |   554,498.8 |   550,170.4 |
|      32 |        896,751.8 |          908,569.4 |   908,687.4 |   852,593=
=2E2 |   892,222.6 |   919,105.0 |   874,487.8 |   920,554.6 |
|      64 |      1,488,013.0 |        1,500,952.6 | 1,467,258.8 | 1,528,428=
=2E2 | 1,530,458.6 | 1,526,439.6 | 1,459,185.2 | 1,480,434.0 |
|     128 |      1,944,216.0 |        1,974,618.6 | 1,927,277.6 | 1,748,598=
=2E4 | 1,989,212.0 | 1,975,526.2 | 1,839,080.4 | 1,903,844.4 |
|     256 |      2,142,823.0 |        2,185,436.6 | 2,126,787.8 | 2,194,752=
=2E2 | 2,189,521.2 | 2,164,454.2 | 1,987,121.0 | 2,081,487.0 |
|     512 |      2,232,887.4 |        2,279,553.4 | 2,215,265.8 | 2,274,402=
=2E6 | 2,278,595.6 | 2,262,156.4 | 2,047,572.8 | 2,169,430.8 |
|    1024 |      2,269,308.2 |        2,312,200.0 | 2,250,841.0 | 2,278,423=
=2E2 | 2,328,832.6 | 2,288,490.0 | 2,075,494.2 | 2,190,907.8 |
|    2048 |      2,281,539.0 |        2,336,340.6 | 2,255,446.8 | 2,221,195=
=2E4 | 2,374,069.2 | 2,330,833.2 | 2,083,151.4 | 2,196,610.0 |
|    4096 |      2,315,628.8 |        2,367,224.6 | 2,284,841.4 | 2,397,385=
=2E8 | 2,373,043.2 | 2,394,276.6 | 2,104,235.0 | 2,233,600.0 |
|    8192 |      2,341,296.8 |        2,401,307.8 | 2,320,777.4 | 2,336,329=
=2E0 | 2,331,216.4 | 2,391,361.6 | 2,122,129.4 | 2,250,452.6 |
|   16384 |      2,435,181.6 |        2,509,588.2 | 2,422,407.8 | 2,378,702=
=2E8 | 2,514,325.8 | 2,552,565.8 | 2,200,619.0 | 2,350,706.0 |
+---------+------------------+--------------------+-------------+----------=
---+-------------+-------------+-------------+-------------+

Sebastian

