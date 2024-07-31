Return-Path: <linux-kernel+bounces-269590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F4943499
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0343E1F22886
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130C1B140E;
	Wed, 31 Jul 2024 17:00:48 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798512B8B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445248; cv=none; b=DbMmSf/Ugwm4BTMyCVR9FZHqBa0QSeM52pBxB3FY3xUOxKFa3oimryMhEgCIEmhb6JO2v4AXyrQ2+H8sLSjqY/gzlsw5qqfDyiKoIfhQ2WbHOnQwYi6PMuFFgHb76C50Fe2nwDpx0zNRJiIUbFXwHCunviq8M3cI2OC60lwFtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445248; c=relaxed/simple;
	bh=tpIhA9/lXz4di34ShqYJb4lb2ZEl8xxW+Btk8olSLUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1mpEqw1iD/WNFyE7W0t0QhN3omgno/at8Det3CI0Bz7FIzNitlU2M0EFIhtQPyu1JL2NNmLpCpHcET8nSSLtwKMauZKYpf3VnpBxEKSg9palo1aOBZ0WvDjCwxfVIfvmdzbaJBJ6MWREbLJpC0YLG8mlniWypk5d92Gfbkmhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so3858059a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445246; x=1723050046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QttKJQSjtCsWgra3NZFLws+Aho/u69nwOPNMumWnPDw=;
        b=T9akVxBX4cPWBVdgco47h8TWr9n+RIC4EQjKmGZ/fFzk9NvURVqiybkJ7g6SLpxMZ4
         2Ud9dmGoc529Ca2jcIjIFf3YOfIuFmqp/dB2GQuxLR4rfjGblKo8Zicqf1AOqi5YBGwO
         5p+LRylQyp4OuvV3Rj/Cwlh48YhPZpfNJzeqaSkCoLxNNYvBB4nzzKxZaSVoRwqPb7zx
         vAqHtDFqByMN5nBaup83oubXquuQuymbcGnhCBTMUlOVa8Aa9HF2jMtmjVuCQ8vatZ6X
         9HUimZHUBvQwjOmspD2NtLRW6sMY5I2Ru96UvtkLDLegOoB1dQ4vKQjQHuTcRJxWyTaj
         kozg==
X-Forwarded-Encrypted: i=1; AJvYcCW6qT2P3FTTrZVW+j8NhwEWUi4moazUJUexDwqrL9dos6fwpH13pXN3tMlOpZ9uoAetr3MVIHUm1bBAfSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaag/rIWjqAEW3DeSmjJXBqCY6HCdbXy6qz+lLTP+PcrwTk30D
	kNG2TMZbmHbrDfLBOA+3b5MO34a48MlXSnI8n+PLxGWVIb6HT83+WbaYB8VEMhCaNjS6w80TASC
	qAj/djAcF2NpsNV2O3BkSwfxpwSEJdQ==
X-Google-Smtp-Source: AGHT+IFh/utt/ghA9nc/DS5DYnqo7DIAwl9v+vINNO/vz7FPlYGKRTgIVqs715kC3+5rAtZhH913MWg804PsnZVVzss=
X-Received: by 2002:a17:90b:205:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2cf7e73082fmr11945378a91.41.1722445245501; Wed, 31 Jul 2024
 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <ZqpSuBqSZsj2FEcO@x1> <5d534069-a1b3-4789-8d76-f36f956a1e12@linux.intel.com>
In-Reply-To: <5d534069-a1b3-4789-8d76-f36f956a1e12@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 31 Jul 2024 10:00:32 -0700
Message-ID: <CAM9d7cgCr+ZS49WxqrLEhwt5KRCNgjTgHiMC+j6_EfnV4sLxUQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support branch counters in block annotation
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, irogers@google.com, peterz@infradead.org, 
	Andi Kleen <andi@firstfloor.org>, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi guys,

On Wed, Jul 31, 2024 at 8:31=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> Hi Arnaldo,
>
> On 2024-07-31 11:05 a.m., Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 03, 2024 at 01:03:47PM -0700, kan.liang@linux.intel.com wro=
te:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The branch counters logging (A.K.A LBR event logging) introduces a
> >> per-counter indication of precise event occurrences in LBRs. It can
> >> provide a means to attribute exposed retirement latency to combination=
s
> >> of events across a block of instructions. It also provides a means of
> >> attributing Timed LBR latencies to events.
> >>
> >> The kernel support and basic perf tool support have been merged.
> >> https://lore.kernel.org/lkml/20231025201626.3000228-1-kan.liang@linux.=
intel.com/
> >>
> >> This series is to provide advanced perf tool support via adding the
> >> branch counters information in block annotation. It can further
> >> facilitate the analysis of branch blocks.
> >>
> >> The patch 1 and 2 are to fix two existing issues of --total-cycles and
> >> the branch counters feature.
> >>
> >> The patch 3-9 are the advanced perf tool support.
> >
> > I couldn't find any newer versions of this series nor reviews, is that
> > right?
>
> Right. There is no newer version nor reviews.
>
> The patch series can be successfully applied on top of the latest
> tmp.perf-tools-next (on top of the commit 756785ab6380 ("perf list: Give
> clues if failed to open tracing events directory")).
>
> I think we can still use it for the review.
>
> >
> > I'll try and review this soon, but if someone else could take a look,
> > try it and provide a Reviewed-by or at least an Acked-by, that would
> > help!

Sure, I'll take a look!

Thanks,
Namhyung

> >
> >> Here are some examples.
> >>
> >> perf annotation:
> >>
> >> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,cou=
nter
> >> $perf report  --total-cycles --stdio
> >>
> >>  # To display the perf.data header info, please use --header/--header-=
only options.
> >>  #
> >>  #
> >>  # Total Lost Samples: 0
> >>  #
> >>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch=
-misses }'
> >>  # Event count (approx.): 1610046
> >>  #
> >>  # Branch counter abbr list:
> >>  # branch-instructions:ppp =3D A
> >>  # branch-misses =3D B
> >>  # '-' No event occurs
> >>  # '+' Event occurrences may be lost due to branch counter saturated
> >>  #
> >>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          B=
ranch Counter [Program Block Range]
> >>  # ...............  ..............  ...........  ..........  .........=
.............  ..
> >>  #
> >>            57.55%            2.5M        0.00%           3            =
 |A   |-   |                 ...
> >>            25.27%            1.1M        0.00%           2            =
 |AA  |-   |                 ...
> >>            15.61%          667.2K        0.00%           1            =
 |A   |-   |                 ...
> >>             0.16%            6.9K        0.81%         575            =
 |A   |-   |                 ...
> >>             0.16%            6.8K        1.38%         977            =
 |AA  |-   |                 ...
> >>             0.16%            6.8K        0.04%          28            =
 |AA  |B   |                 ...
> >>             0.15%            6.6K        1.33%         946            =
 |A   |-   |                 ...
> >>             0.11%            4.5K        0.06%          46            =
 |AAA+|-   |                 ...
> >>
> >> (The below output is in the TUI mode. Users can press 'B' to display
> >> the Branch counter abbr list.)
> >>
> >> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-mi=
sses }',
> >> 4000 Hz, Event count (approx.):
> >> f3  /home/sdp/test/tchain_edit [Percent: local period]
> >> Percent       =E2=94=82 IPC Cycle       Branch Counter (Average IPC: 1=
.39, IPC Coverage: 29.4%)
> >>               =E2=94=82                                     0000000000=
401755 <f3>:
> >>   0.00   0.00 =E2=94=82                                       endbr64
> >>               =E2=94=82                                       push    =
%rbp
> >>               =E2=94=82                                       mov     =
%rsp,%rbp
> >>               =E2=94=82                                       movl    =
$0x0,-0x4(%rbp)
> >>   0.00   0.00 =E2=94=821.33     3          |A   |-   |      =E2=86=93 =
jmp     25
> >>  11.03  11.03 =E2=94=82                                 11:   mov     =
-0x4(%rbp),%eax
> >>               =E2=94=82                                       and     =
$0x1,%eax
> >>               =E2=94=82                                       test    =
%eax,%eax
> >>  17.13  17.13 =E2=94=822.41     1          |A   |-   |      =E2=86=93 =
je      21
> >>               =E2=94=82                                       addl    =
$0x1,-0x4(%rbp)
> >>  21.84  21.84 =E2=94=822.22     2          |AA  |-   |      =E2=86=93 =
jmp     25
> >>  17.13  17.13 =E2=94=82                                 21:   addl    =
$0x1,-0x4(%rbp)
> >>  21.84  21.84 =E2=94=82                                 25:   cmpl    =
$0x270f,-0x4(%rbp)
> >>  11.03  11.03 =E2=94=820.61     3          |A   |-   |      =E2=86=91 =
jle     11
> >>               =E2=94=82                                       nop
> >>               =E2=94=82                                       pop     =
%rbp
> >>   0.00   0.00 =E2=94=820.24    20          |AA  |B   |      =E2=86=90 =
ret
> >>
> >> perf script:
> >>
> >> $perf script -F +brstackinsn,+brcntr
> >>
> >>  # Branch counter abbr list:
> >>  # branch-instructions:ppp =3D A
> >>  # branch-misses =3D B
> >>  # '-' No event occurs
> >>  # '+' Event occurrences may be lost due to branch counter saturated
> >>      tchain_edit  332203 3366329.405674:      53030 branch-instruction=
s:ppp:            401781 f3+0x2c (home/sdp/test/tchain_edit)
> >>         f3+31:
> >>         0000000000401774        insn: eb 04                     br_cnt=
r: AA     # PRED 5 cycles [5]
> >>         000000000040177a        insn: 81 7d fc 0f 27 00 00
> >>         0000000000401781        insn: 7e e3                     br_cnt=
r: A      # PRED 1 cycles [6] 2.00 IPC
> >>         0000000000401766        insn: 8b 45 fc
> >>         0000000000401769        insn: 83 e0 01
> >>         000000000040176c        insn: 85 c0
> >>
> >> $perf script -F +brstackinsn,+brcntr -v
> >>
> >>      tchain_edit  332203 3366329.405674:      53030 branch-instruction=
s:ppp:            401781 f3+0x2c (/home/sdp/test/tchain_edit)
> >>         f3+31:
> >>         0000000000401774        insn: eb 04                     br_cnt=
r: branch-instructions:ppp 2 branch-misses 0      # PRED 5 cycles [5]
> >>         000000000040177a        insn: 81 7d fc 0f 27 00 00
> >>         0000000000401781        insn: 7e e3                     br_cnt=
r: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [6] 2.00 =
IPC
> >>         0000000000401766        insn: 8b 45 fc
> >>         0000000000401769        insn: 83 e0 01
> >>         000000000040176c        insn: 85 c0
> >>
> >> Kan Liang (9):
> >>   perf report: Fix --total-cycles --stdio output error
> >>   perf report: Remove the first overflow check for branch counters
> >>   perf evlist: Save branch counters information
> >>   perf annotate: Save branch counters for each block
> >>   perf evsel: Assign abbr name for the branch counter events
> >>   perf report: Display the branch counter histogram
> >>   perf annotate: Display the branch counter histogram
> >>   perf script: Add branch counters
> >>   perf test: Add new test cases for the branch counter feature
> >>
> >>  tools/perf/Documentation/perf-report.txt |   1 +
> >>  tools/perf/Documentation/perf-script.txt |   2 +-
> >>  tools/perf/builtin-annotate.c            |  13 +-
> >>  tools/perf/builtin-diff.c                |   8 +-
> >>  tools/perf/builtin-report.c              |  25 ++-
> >>  tools/perf/builtin-script.c              |  69 +++++++-
> >>  tools/perf/builtin-top.c                 |   4 +-
> >>  tools/perf/tests/shell/record.sh         |  17 +-
> >>  tools/perf/ui/browsers/annotate.c        |  18 +-
> >>  tools/perf/ui/browsers/hists.c           |  18 +-
> >>  tools/perf/util/annotate.c               | 209 +++++++++++++++++++++-=
-
> >>  tools/perf/util/annotate.h               |  24 ++-
> >>  tools/perf/util/block-info.c             |  66 ++++++-
> >>  tools/perf/util/block-info.h             |   8 +-
> >>  tools/perf/util/branch.h                 |   1 +
> >>  tools/perf/util/disasm.c                 |   1 +
> >>  tools/perf/util/evlist.c                 |  66 +++++++
> >>  tools/perf/util/evlist.h                 |   2 +
> >>  tools/perf/util/evsel.c                  |  15 +-
> >>  tools/perf/util/evsel.h                  |  12 ++
> >>  tools/perf/util/hist.c                   |   5 +-
> >>  tools/perf/util/hist.h                   |   2 +-
> >>  tools/perf/util/machine.c                |   3 +
> >>  23 files changed, 519 insertions(+), 70 deletions(-)
> >>
> >> --
> >> 2.38.1
> >

